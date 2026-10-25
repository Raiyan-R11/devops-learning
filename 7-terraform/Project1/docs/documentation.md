# Terraform Project 1: Deploy WordPress Using Terraform

Deploy a full WordPress stack on a single EC2 instance with Terraform: the instance, its security group and rules, and a user data script that installs Apache, PHP and MariaDB and configures WordPress on first boot. No manual steps on the server.

**Region:** Europe (Stockholm), `eu-north-1`
**Terraform:** v1.16.5, AWS provider `6.68.0`, state in S3 (`project1/terraform.tfstate`)
**Evidence date:** 25 October 2026 (apply, WordPress setup, destroy)

## Contents

- [Architecture](#architecture)
- [Files](#files)
- [Resource inventory](#resource-inventory)
- [Terraform configuration](#terraform-configuration)
- [User data script](#user-data-script)
- [Deployment](#deployment)
- [Testing](#testing)
- [Cleanup](#cleanup)
- [Troubleshooting and lessons learned](#troubleshooting-and-lessons-learned)
- [References](#references)

## Architecture

Everything runs on one instance in the default VPC. The default VPC already has an Internet Gateway, a route to it, and public subnets, so the only networking Terraform creates is the security group.

```text
Browser ──HTTP 80──▶ Security group (web_sg) ──▶ EC2 t3.micro (Amazon Linux 2023)
                                                  ├─ Apache (httpd)      :80
                                                  ├─ PHP-FPM             runs WordPress
                                                  └─ MariaDB             localhost only
```

| Layer       | Component                    | Notes                                                       |
| ----------- | ---------------------------- | ----------------------------------------------------------- |
| Network     | Default VPC                  | Looked up with a data source, not created                   |
| Firewall    | `web_sg`                     | HTTP 80 from anywhere, SSH 22 from my IP only, all outbound |
| Compute     | `aws_instance.web`           | `t3.micro`, public IPv4, IMDSv2 required                    |
| Web server  | Apache + PHP-FPM             | Apache hands `.php` requests to PHP-FPM                     |
| Database    | MariaDB 10.5                 | On the same instance, reachable only from `localhost`       |
| Application | WordPress (latest, 7.1.3)    | Downloaded from wordpress.org at boot                       |

## Files

| File                       | Purpose                                                              |
| -------------------------- | -------------------------------------------------------------------- |
| `provider.tf`              | `terraform {}` block (AWS provider version, S3 backend) and `provider "aws"` |
| `main.tf`                  | AMI and VPC data sources, security group and rules, EC2 instance     |
| `variables.tf`             | Inputs: instance type, DB name/user/password, my IP, open CIDR       |
| `outputs.tf`               | `instance_id`, `instance_public_ip`, `wordpress_url`                 |
| `user_data.sh.tftpl`       | Bash script rendered by `templatefile()` and run by cloud-init       |
| `terraform.tfvars.example` | Example values; the real `terraform.tfvars` is gitignored            |

## Resource inventory

Identifiers are from the apply output on 25 October 2026. All of them were destroyed afterwards.

| Terraform address                               | AWS identifier          | Detail                            |
| ----------------------------------------------- | ----------------------- | --------------------------------- |
| `aws_security_group.web_sg`                     | `sg-04e6e7a814fe54271`  | Default VPC                       |
| `aws_vpc_security_group_ingress_rule.http`      | `sgr-09fb62e9653c71025` | TCP 80 from `0.0.0.0/0`           |
| `aws_vpc_security_group_ingress_rule.ssh`       | `sgr-00c1d5b36e42db4b3` | TCP 22 from my IP (`/32`)         |
| `aws_vpc_security_group_egress_rule.all`        | `sgr-09605d2830e1bdae8` | All protocols to `0.0.0.0/0`      |
| `aws_instance.web`                              | `i-026c9bd21fa00939a`   | `t3.micro`, public IP `13.61.177.156` |

## Terraform configuration

### AMI lookup

The AMI is found with a data source instead of a hard-coded ID, so it always resolves to the latest image in the current Region.

```hcl
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
```

| Pattern part      | Why                                                                 |
| ----------------- | ------------------------------------------------------------------- |
| `al2023-ami-2023` | Excludes `al2023-ami-minimal-…`, which leaves out common packages   |
| `*-x86_64`        | Excludes the `arm64` build, which a `t3.micro` cannot run           |

### Security group

The rules are separate `aws_vpc_security_group_*_rule` resources rather than inline `ingress {}` blocks, which is what the AWS provider docs recommend. SSH is limited to my IP through `var.my_ip`, so the real address lives only in the gitignored `terraform.tfvars`.

| Rule      | Protocol / port | Source / destination | Purpose                                  |
| --------- | --------------- | -------------------- | ---------------------------------------- |
| `http`    | TCP 80          | `var.all_ip` (`0.0.0.0/0`) | Public website                     |
| `ssh`     | TCP 22          | `var.my_ip` (`x.x.x.x/32`) | Admin access from my machine only  |
| `all`     | All (`-1`)      | `0.0.0.0/0`          | Package and WordPress downloads at boot  |

### EC2 instance

```hcl
resource "aws_instance" "web" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    db_name = var.db_name, db_user = var.db_user, db_password = var.db_password
  })

  user_data_replace_on_change = true

  metadata_options {
    http_tokens = "required"
  }
}
```

| Argument                      | Why                                                                                   |
| ----------------------------- | ------------------------------------------------------------------------------------- |
| `associate_public_ip_address` | Gives the public endpoint, and lets the instance reach the internet to install packages |
| `templatefile()`              | Fills `${db_name}`, `${db_user}`, `${db_password}` into the script before it is sent   |
| `user_data_replace_on_change` | User data only runs on first boot, so a changed script needs a new instance to take effect |
| `http_tokens = "required"`    | Enforces IMDSv2, which blocks SSRF attacks from stealing instance credentials          |

### Variables and outputs

`db_password` is marked `sensitive`, so it is hidden in plan output and the rendered `user_data` shows as `(sensitive value)`. Values come from `terraform.tfvars`; `terraform.tfvars.example` shows the expected keys with placeholder values.

| Output               | Value                                 |
| -------------------- | ------------------------------------- |
| `instance_id`        | `aws_instance.web.id`                 |
| `instance_public_ip` | `aws_instance.web.public_ip`          |
| `wordpress_url`      | `"http://${aws_instance.web.public_ip}"` |

## User data script

`user_data.sh.tftpl` builds the LAMP stack and configures WordPress. cloud-init runs it once, as root, on first boot.

| Step | Commands | Purpose |
| ---- | -------- | ------- |
| 1 | `set -euxo pipefail` | Stop at the first error and log every command |
| 2 | `dnf install -y httpd php-fpm php php-mysqlnd mariadb105-server wget` | Web server, PHP runtime, PHP's MySQL driver, database |
| 3 | `systemctl enable --now httpd php-fpm mariadb` | Start all three now and on every reboot |
| 4 | `mysql -e "CREATE DATABASE …; CREATE USER …; GRANT …; FLUSH PRIVILEGES;"` | WordPress database and a user that can only connect from `localhost` |
| 5 | `wget`, `tar -xzf`, `cp -r wordpress/* /var/www/html/` | Download and install WordPress into Apache's web root |
| 6 | `cp wp-config-sample.php wp-config.php`, `sed -i "s/…/…/"` | Point WordPress at the database |
| 7 | `chown -R apache:apache /var/www/html/`, `systemctl restart httpd` | Let Apache own the files, then reload |

The `CREATE USER` and the password `sed` line are wrapped in `set +x` / `set -x`, so tracing is off while the password is in the command and it is not written to `/var/log/cloud-init-output.log`.

**Template gotcha:** inside a `.tftpl` file, `${…}` is Terraform syntax. A bash variable that needs braces has to be written `$${VAR}`.

## Deployment

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

The apply created 5 resources. The security group came first because the rules and the instance both reference its ID; the instance took 14 seconds to create.

![terraform apply output: 5 added, with instance_id, instance_public_ip and wordpress_url outputs](images/terraform-apply-outputs.png)

_The `instance_id` change from `i-09ddce9273b4899ba` in this output is a stale state entry, explained in [troubleshooting](#problem-2-stale-state-after-deleting-in-the-console)._

## Testing

### Test 1: User data completed

I connected to the instance with Session Manager and read the end of the cloud-init log. The script ran to the end (`set -e` would have stopped it at any failure), and cloud-init finished 60 seconds after boot.

```bash
sudo tail -20 /var/log/cloud-init-output.log
```

![cloud-init-output.log ending with the WordPress install steps and Cloud-init finished](images/cloud-init-output-log.png)

**Result:** The traced lines go straight from the `sed` for the database name and user to `set +x`, then `chown`. The password `sed` is not in the log.

_This run was before I added `wget -q` and `cd /tmp`, which is why the log has the download progress bar._

### Test 2: Public endpoint and database connection

Opening `wordpress_url` (`http://13.61.177.156`) redirected to the WordPress installer.

![WordPress installer language selection at 13.61.177.156/wp-admin/install.php](images/wordpress-install-language.png)

![WordPress installer step 1: site title, admin username and password](images/wordpress-install-site-info.png)

**Result:** WordPress only shows the installer when PHP is running and it can connect to the database with the credentials in `wp-config.php`, so this page proves the whole stack: security group, Apache, PHP-FPM, `php-mysqlnd` and MariaDB.

### Test 3: Working WordPress site

After finishing the installer, the public site served the default "Hello world!" post.

![WordPress homepage for raiyan-wp-site with the Hello world post](images/wordpress-homepage.png)

The admin dashboard loaded (WordPress 7.1.3, Twenty Twenty-Five theme):

![wp-admin dashboard showing WordPress 7.1.3](images/wp-admin-dashboard.png)

I added a second user to confirm that writes reach the database:

![wp-admin Users list with an administrator and a test subscriber](images/wp-admin-users.png)

**Result:** Logging in, reading posts and creating a user all work, so MariaDB is storing and returning data.

## Cleanup

```powershell
terraform destroy
```

All 5 resources were destroyed. Terraform removed the three rules and the instance before the security group, because a security group cannot be deleted while it is still attached.

![terraform destroy output: 5 destroyed](images/terraform-destroy.png)

## Troubleshooting and lessons learned

### Problem 1: The AMI filter picked the minimal image

**Evidence:** My first filter was `al2023*`. Looking up the AMI it chose showed:

```powershell
aws ec2 describe-images --image-ids ami-02bcd73435e220794 --region eu-north-1 --query "Images[].[Name,Architecture]" --output table
```

```text
al2023-ami-minimal-2023.12.20261021.0-kernel-6.18-x86_64 | x86_64
```

**Cause:** `al2023*` matches the standard, minimal, `x86_64` and `arm64` images. `most_recent = true` takes the newest match, which happened to be minimal. The next release could just as easily have been `arm64`, which a `t3.micro` cannot boot.

**Fix:** `al2023-ami-2023.*-x86_64`. The `2023` right after `al2023-ami-` rules out minimal, and the `-x86_64` ending rules out ARM.

**Lesson:** A `*` in a data source filter matches more than you expect. Check what "latest" actually returned before relying on it.

### Problem 2: Stale state after deleting in the console

**Evidence:** `terraform plan` showed `module.ec2.aws_instance.this: Refreshing state... [id=i-09ddce9273b4899ba]`, a resource from an earlier module-based version, and `terraform state list` still listed it. `aws ec2 describe-instances` returned `InvalidInstanceID.NotFound`.

**Cause:** I had deleted that instance in the AWS console. The console does not update Terraform's state, so the record stayed behind. The refresh during `plan` noticed the instance was gone, which is why there was nothing to destroy.

**Fix:** The next apply wrote a fresh state without it. `terraform state rm` would also have removed it; it only edits state and never touches AWS.

**Lesson:** State is Terraform's record of what it built, not AWS itself. Delete with `terraform destroy`, not the console, so the two stay in sync.

### Problem 3: Passwords in the cloud-init log

**Cause:** `set -x` prints every command after Terraform has filled in the template, so the `CREATE USER … IDENTIFIED BY '…'` line and the password `sed` would be written to `/var/log/cloud-init-output.log` in plain text.

**Fix:** `set +x` before those commands and `set -x` after them.

### Experiment: what triggers `user_data_replace_on_change`

I added a line to `user_data.sh.tftpl` and ran `terraform plan`. Terraform compares the rendered script with the one stored in state, and any difference, even a comment, forces a new instance:

![terraform plan showing user_data (sensitive value) forces replacement](images/plan-user-data-forces-replacement.png)

**Lesson:** Replacing the instance also replaces its public IP and wipes WordPress, because the database is on the instance. A real deployment would keep the database separate (for example on RDS) so the web server can be replaced freely.

### Other things I learned

- The default VPC already has an Internet Gateway and public subnets, so a single-instance project does not need to create any networking.
- On Amazon Linux 2023, Apache does not run PHP itself; it passes requests to PHP-FPM. WordPress also needs `php-mysqlnd` to talk to MariaDB.
- `terraform fmt` and `terraform validate` catch formatting and syntax issues before `plan` talks to AWS.

## References

- [Terraform: `aws_instance`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) — `user_data`, `user_data_replace_on_change`, `metadata_options`.
- [Terraform: `aws_ami` data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) — `most_recent`, `owners`, `filter`.
- [Terraform: `aws_vpc_security_group_ingress_rule`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) — separate security group rules.
- [Terraform: `templatefile` function](https://developer.hashicorp.com/terraform/language/functions/templatefile) — rendering the user data script.
- [AWS: Run commands at launch with user data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html) — when user data runs and where its output goes.
- [AWS: Use IMDSv2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html) — why session tokens matter.
- [AWS: Install LAMP on Amazon Linux 2023](https://docs.aws.amazon.com/linux/al2023/ug/ec2-lamp-amazon-linux-2023.html) — package names for Apache, PHP and MariaDB.
- [WordPress: How to install WordPress](https://developer.wordpress.org/advanced-administration/before-install/howto-install/) — database and `wp-config.php` steps.
