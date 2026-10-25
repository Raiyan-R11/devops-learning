# DevOps Learning Journey

### Linux & Scripting

![Linux](https://img.shields.io/badge/OS-Linux-FCC624?logo=linux&logoColor=black)
![Amazon Linux](https://img.shields.io/badge/Distro-Amazon_Linux-FF9900?logo=amazonaws&logoColor=white)
![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnubash&logoColor=white)
![PowerShell](https://img.shields.io/badge/CLI-PowerShell-5391FE?logo=powershell&logoColor=white)

### Cloud & Networking

![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)
![EC2](https://img.shields.io/badge/Amazon-EC2-FF9900?logo=amazonaws&logoColor=white)
![VPC](https://img.shields.io/badge/Amazon-VPC-8C4FFF?logo=amazonaws&logoColor=white)
![ALB](https://img.shields.io/badge/Application-Load_Balancer-8C4FFF?logo=amazonaws&logoColor=white)
![Auto Scaling](https://img.shields.io/badge/EC2-Auto_Scaling-FF9900?logo=amazonaws&logoColor=white)
![Route 53](https://img.shields.io/badge/Amazon-Route_53-8C4FFF?logo=amazonaws&logoColor=white)
![ACM](https://img.shields.io/badge/AWS-Certificate_Manager-DD344C?logo=amazonaws&logoColor=white)
![S3](https://img.shields.io/badge/Amazon-S3-569A31?logo=amazons3&logoColor=white)
![Cloudflare](https://img.shields.io/badge/DNS-Cloudflare-F38020?logo=cloudflare&logoColor=white)
![Nginx](https://img.shields.io/badge/Web_Server-Nginx-009639?logo=nginx&logoColor=white)

### Infrastructure as Code & Containers

![Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED?logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Orchestration-Docker_Compose-2496ED?logo=docker&logoColor=white)

### Development

![Git](https://img.shields.io/badge/Version_Control-Git-F05032?logo=git&logoColor=white)
![VS Code](https://img.shields.io/badge/Editor-VS_Code-007ACC?logo=visualstudiocode&logoColor=white)
![draw.io](https://img.shields.io/badge/Diagrams-draw.io-F08705?logo=diagramsdotnet&logoColor=white)
![Markdown](https://img.shields.io/badge/Docs-Markdown-000000?logo=markdown&logoColor=white)

My working notebook from the **CoderCo DevOps** course - from a Linux terminal to infrastructure that Terraform builds and tears down on its own. Everything here was built by hand, broken at least once, and written up afterwards: the architecture, the screenshots, and the part most write-ups skip, **what went wrong and how I fixed it**.

**Short on time?** Go straight to the [highlights](#highlights).

## Modules

| # | Module | What's inside | Explore |
|---|--------|---------------|---------|
| 01 | **Linux** | 20+ OverTheWire Bandit levels cleared, with write-ups for the tricky ones - SSH keys, setuid, ports | [View](1-linux/) |
| 02 | **Bash** | 15 levels of shell scripting, ending in an `Arena_Boss` | [View](2-bash/) |
| 03 | **Git** | Workflow notes and practice | [View](3-git/notes.md) |
| 04 | **Networking** | Nginx on EC2 behind a Cloudflare-proxied subdomain | [View](4-networking/networking-lab.md) |
| 05 | **Docker** | Multi-stage builds and a scaled Flask + Redis + Nginx stack | [View](5-docker/) |
| 06 | **AWS** | A custom VPC, then an HTTPS ALB with Auto Scaling | [View](6-AWS/) |
| 07 | **Terraform** | A reusable EC2 module, S3 remote state, and WordPress as code | [View](7-terraform/) |

## Highlights

- **HTTPS load balancer with Auto Scaling** *(06 - AWS)* - an ALB across two AZs with an ACM certificate, a Route 53 alias, and an ASG. The instances only accept traffic from the ALB. [Write-up](6-AWS/Project2/documentation.md)
- **Custom VPC from scratch** *(06 - AWS)* - public and private subnets, IGW and NAT routing, and a bastion for private SSH. Includes a Zonal vs Regional NAT comparison. [Write-up](6-AWS/Project1/documentation.md)
- **WordPress with Terraform** *(07)* - EC2, security groups, and a user data script that installs Apache, PHP, MariaDB, and WordPress on first boot. Nothing configured by hand on the server. [Write-up](7-terraform/Project1/docs/documentation.md)
- **Flask + Redis + Nginx** *(05 - Docker)* - a visit counter behind an Nginx reverse proxy, scaled with Compose. [Challenge](5-docker/challenge/README.md)

## Things that broke (and what they taught me)

The bugs taught me more than the times it worked first try:

- **ALB targets stuck unhealthy (502s)** - the ASG instances had no public IP, so `dnf` timed out in user data and the web server never installed. On top of that, the launch template had no security group, so they got the default one. Fixed both, and now I check the system log first.
- **A Terraform plan that wanted to replace my instance** - changing `user_data` forces a new instance. Better to find that out from `plan` than from `apply`.
- **Subdomain down behind Cloudflare** - Full mode tried HTTPS to an Nginx origin that only served HTTP. Browser → Cloudflare and Cloudflare → origin are two separate connections, each with its own TLS settings.

## Repository Structure

```text
devops-learning/
├── 1-linux/        # Bandit write-ups
├── 2-bash/         # Shell scripting levels
├── 3-git/          # Version control
├── 4-networking/   # Nginx, DNS, Cloudflare
├── 5-docker/       # Containers and Compose
├── 6-AWS/          # VPC and ALB projects
├── 7-terraform/    # Infrastructure as Code
└── linkedin/       # Posts I wrote about these builds
```

Each project has its own `documentation.md` with the architecture diagram, resource inventory, test evidence, and troubleshooting notes.

## Progress

| Module | Status |
|--------|--------|
| 01 - Linux | ✅ Done |
| 02 - Bash | ✅ Done |
| 03 - Git | ✅ Done |
| 04 - Networking | ✅ Done |
| 05 - Docker | ✅ Done |
| 06 - AWS | ✅ Done |
| 07 - Terraform | 🚧 Project 2 (cloud-init) in progress |
| 08 - CI/CD | ⏳ Up next |
| 09 - Kubernetes | ⏳ Up next |

## My Setup

Windows 11 with PowerShell and Git Bash · Docker Desktop · AWS (`eu-north-1`) · Terraform with an S3 backend · draw.io for diagrams
