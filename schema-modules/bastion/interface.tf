variable "env_prefix" {
  type = "string"
}

variable "key_name" {}

variable "subnet_id" {}

variable "vpc_id" {}

variable "ami_id" {
  type    = "string"
  default = "ami-d0f506b0"
}

variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}

output "bastion_node_address" {
  value = "${aws_instance.bastion_node.public_ip}"
}
