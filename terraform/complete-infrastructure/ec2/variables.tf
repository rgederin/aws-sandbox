variable "ec2_ami_id" {
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "nat_ec2_ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "rds_address" {
  type = string
}

