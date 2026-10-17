variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

locals {
  instance_ami = "ami-0aba19e56f3eaec05"
}
