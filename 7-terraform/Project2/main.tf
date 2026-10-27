# AMI --------------------------------------------
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# EC2 instance -----------------------------------
resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.al2023.value
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  associate_public_ip_address = true

  user_data_base64 = data.cloudinit_config.nginx.rendered

  user_data_replace_on_change = true

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name    = "cloud-init-nginx-instance"
    Project = "cloud-init-nginx"
  }
}

# Cloud-init config ------------------------------
data "cloudinit_config" "nginx" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init.yaml.tftpl", {
      page_title = var.page_title
    })
  }
}

# VPC - default ------------------------------------
data "aws_vpc" "default" {
  default = true
}

# AWS Security Group -------------------------------
resource "aws_security_group" "nginx_sg" {
  name   = "nginx_sg"
  vpc_id = data.aws_vpc.default.id
}

## inbound - HTTP ----------------------------------
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.nginx_sg.id
  cidr_ipv4         = local.all_ip
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# outbound - Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.nginx_sg.id
  cidr_ipv4         = local.all_ip
  ip_protocol       = "-1"
}
