# Project 2 — Lab notes

Status: Not yet recorded. Fill this in while building; the guide is a plan, not completion evidence.

## Resource inventory

| Item | Actual value |
|---|---|
| Date / Region | |
| Availability Zones | |
| VPC name / CIDR | |
| Public subnets / CIDRs / AZs | |
| Private subnets / CIDRs / AZs | |
| Reused Project 1 resources | |
| ALB name / DNS name | |
| ALB SG / EC2 SG | |
| Target group | |
| EC2 A / private IP | |
| EC2 B / private IP | |

## Results

| Check | Actual observation | Screenshot / evidence |
|---|---|---|
| Both targets Healthy | | |
| Page A through ALB | | |
| Page B through ALB | | |
| Repeated requests show both | | |
| No public EC2 addresses | | |
| EC2 HTTP source is ALB SG only | | |
| Direct private-IP test and client network context | | |
| Optional one-instance failure test | | |
| Optional Route 53 / HTTPS / ASG | | |

## Explain in your own words

- What path does an incoming HTTP request take?
- Why does the ALB need two public subnets?
- Why do these private instances need NAT for the user-data installation?
- How does an ALB SG reference restrict EC2 access?
- What does the root health check prove, and what does it not prove?
- Why might browser refreshes not alternate perfectly?

## Problems and fixes

| Symptom | Evidence / health reason | Cause | Change made | Retest result |
|---|---|---|---|---|
| | | | | |

## Cleanup

- Date:
- Deleted resources:
- Retained resources and why:
- Remaining billable resources checked:
