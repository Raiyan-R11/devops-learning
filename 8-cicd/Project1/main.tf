# EC2 Instance -----------------------------------
resource "aws_instance" "web" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.nano"
  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]
  associate_public_ip_address = true

  metadata_options { http_tokens = "required" }

  tags = {
    Name = "cicd instance"
  }
}

