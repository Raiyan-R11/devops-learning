variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_name" {
  type = string
}
variable "db_user" {
  type = string
}

variable "my_ip" {
  type = string
}
variable "all_ip" {
  type = string
}
