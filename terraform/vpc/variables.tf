variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "ec2_ami_id" {
  description = "AMI identifier for EC2 instance"
  type        = string
  default     = "ami-08d9a394ac1c2994c"
}

variable "nat_ec2_ami_id" {
  description = "AMI identifier for NAT EC2 instance"
  type        = string
  default     = "ami-004b0f60"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 instance ssh key"
  type        = string
  default     = "rgederin-us-west-1"
}

variable "vpc_cidr_block" {
  description = "VCP IP range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public subnet IP range"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_az" {
  description = "Availability zone for public subnet"
  type        = string
  default     = "us-west-1a"
}

variable "private_subnet_cidr_block" {
  description = "Public subnet IP range"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_az" {
  description = "Availability zone for private subnet"
  type        = string
  default     = "us-west-1b"
}
