# DevOps Learning Journey

Hands-on projects, exercises, and technical notes from my **CoderCo DevOps learning journey**, covering Linux, Bash, Git, networking, Docker, AWS, and Terraform.

Explore the modules below or start with the featured projects. Lab write-ups include architecture diagrams, configuration details, screenshots, and lessons learned from troubleshooting.

## Learning modules

| Module | What is inside | Start here |
|---|---|---|
| **01 · Linux** | Selected OverTheWire Bandit level write-ups | [Linux exercises](1-linux/) |
| **02 · Bash** | Fifteen numbered shell scripts, practice files, logs, and configuration examples | [Bash exercises](2-bash/) |
| **03 · Git** | Git workflow notes and practice files | [Git notes](3-git/notes.md) |
| **04 · Networking** | EC2, Nginx, Cloudflare DNS, encryption modes, and access restrictions | [Networking lab](4-networking/networking-lab.md) |
| **05 · Docker** | Container notes, Flask/MySQL examples, multi-stage Dockerfiles, and a Flask/Redis/Nginx challenge | [Docker module](5-docker/) |
| **06 · AWS** | Infrastructure notes, a VPC lab, and an Application Load Balancer assignment plan | [VPC lab report](6-AWS/Project1/documentation.md) |
| **07 · Terraform** | Root module with a reusable EC2 child module, S3 remote state, and tfvars handling | [Terraform project](7-terraform/test/) |

## Featured labs and projects

### AWS VPC and networking

Built a custom VPC with public and private subnets, Internet Gateway and NAT routing, and EC2 security groups. The public EC2 acts as a combined web server and bastion for private-instance SSH access.

The report covers HTTP and SSH connectivity tests, Regional versus Zonal NAT, and troubleshooting EC2 Instance Connect access.

[Read the lab report](6-AWS/Project1/documentation.md) · [View the architecture](6-AWS/Project1/images/architecture-diagram-zonal-nat.png) · [Assignment guide](6-AWS/Project1/Project-1-VPC-Networking.md)

### EC2, Nginx, and Cloudflare

Deployed Nginx on EC2 and configured a Cloudflare-proxied subdomain. Explored security groups, visitor IP restrictions, and the difference between browser-to-Cloudflare and Cloudflare-to-origin connections.

The write-up includes test results, screenshots, and potential improvements to origin access and TLS configuration.

[Read the networking lab](4-networking/networking-lab.md)

### Docker application exercises

- **Flask and MySQL:** An application and Compose configuration, with original and multi-stage Dockerfile variants for comparison. [Browse the example](5-docker/app1/).
- **Flask, Redis, and Nginx:** A visit-counter application with Compose services, reverse-proxy configuration, and a Redis volume. [Read the challenge](5-docker/challenge/README.md) · [Inspect the Compose configuration](5-docker/challenge/docker-compose.yaml).

### Terraform EC2 module

A root configuration that calls a reusable `ec2` child module to create an EC2 instance. The state is stored in an S3 backend with a bucket in my own account, and the `.tf` files are kept separate from the `.tfvars` values.

The work covers module inputs and outputs, variable declaration and passing, and keeping state, provider caches, and real variable values out of git.

**Status:** Working. `terraform validate` and `terraform plan` pass, and a test instance was created with `terraform apply`. Remaining work: connect the root `terraform.tfvars` to the module's `instance_type` input.

[Browse the project](7-terraform/test/) · [Git ignore rules](7-terraform/.gitignore) · [Example variables](7-terraform/test/terraform.tfvars.example)

### AWS Application Load Balancer

A planned follow-on assignment using an internet-facing ALB, two Availability Zones, private EC2 web servers, target groups, and health checks.

**Status:** Planned.

[Read the build guide](6-AWS/Project2/Project-2-Application-Load-Balancer.md) · [Lab notes](6-AWS/Project2/lab-notes.md)

## Repository layout

```text
devops-learning/
├── 1-linux/        Selected Bandit write-ups
├── 2-bash/         Shell exercises and practice files
├── 3-git/          Git notes and practice
├── 4-networking/   Networking notes, lab report, and screenshots
├── 5-docker/       Notes, application examples, and Compose challenge
├── 6-AWS/          AWS notes and assignment documentation
└── 7-terraform/    Terraform configuration and reusable modules
```

## Working environment

- **Local machine:** Windows 11, PowerShell, and Git Bash.
- **Containers:** Docker Desktop and Docker Compose.
- **Cloud labs:** AWS, including Amazon Linux EC2 instances.
- **Infrastructure as code:** Terraform with an S3 remote backend.
- **Documentation:** Markdown, screenshots, and draw.io architecture diagrams.

## References

- [Git documentation](https://git-scm.com/doc)
- [Docker documentation](https://docs.docker.com/)
- [AWS documentation](https://docs.aws.amazon.com/)
- [Terraform documentation](https://developer.hashicorp.com/terraform/docs)
