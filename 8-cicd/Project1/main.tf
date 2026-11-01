# EC2 Instance -----------------------------------
resource "aws_instance" "web" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type                     = "t3.nano"
  associate_public_ip_address   =        true

  metadata_options         { 
    
    
    http_tokens = "required" 
    }

  tags = {
    Name = "cicd instance"
  }
}

