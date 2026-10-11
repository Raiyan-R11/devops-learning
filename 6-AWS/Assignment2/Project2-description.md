Project 2 - Application Load Balancer

A common DevOps pattern: multiple EC2 instances behind an ALB. This teaches load balancing, health checks, and proper security group isolation.

Objective

Deploy two EC2 instances behind an ALB. The ALB must handle all incoming traffic. EC2 instances should not be accessible directly from the internet.

Tasks

1. Two EC2 Instances

Launch two EC2 instances in the same VPC

Use different availability zones where possible

Install a simple web server using user-data

Each instance should return different content for testing

2. Set Up the ALB

Create an ALB in two public subnets

Add HTTP (port 80) listener

Create a Target Group

Register both EC2 instances

Configure a health check on the root path /

3. Security Groups

ALB SG: allow HTTP from anywhere

EC2 SG: allow HTTP only from the ALB SG

Do not allow direct public access to EC2

4. Testing

Visit the ALB DNS name

Refresh to verify traffic alternates between both instances

Confirm health checks are healthy

Bonus (Optional)

Add a Route53 DNS name and point it to the ALB DNS name via ALIAS record type.

Add an HTTPS listener with ACM

Add an Auto Scaling Group behind the ALB
