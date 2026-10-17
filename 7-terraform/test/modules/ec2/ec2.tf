resource "aws_instance" "this" {
  ami                     = local.instance_ami
  instance_type           = var.instance_type
}
