variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  type    = string
  default = "us-west-2"
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-0e999cbd62129e3b1"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "rgederin-us-west-2"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "dynamodb_table_name" {
  type    = string
  default = "edu-lohika-training-aws-dynamodb"
}

variable "public_subnet_1_az" {
  type    = string
  default = "us-west-2a"
}
variable "public_subnet_1_cidr_block" {
  type    = string
  default = "10.0.4.0/24"
}

variable "public_subnet_az" {
  type    = string
  default = "us-west-2b"
}

variable "private_subnet_1_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_1_az" {
  type    = string
  default = "us-west-2b"
}

variable "private_subnet_2_cidr_block" {
  type    = string
  default = "10.0.3.0/24"
}

variable "private_subnet_2_az" {
  type    = string
  default = "us-west-2c"
}

variable "sns_topic_name" {
  type    = string
  default = "edu-lohika-training-aws-sns-topic"
}

variable "sqs_queue_name" {
  type    = string
  default = "edu-lohika-training-aws-sqs-queue"
}

output "load-balancer-endpoint" {
  value = aws_lb.application_load_balancer.dns_name
}
