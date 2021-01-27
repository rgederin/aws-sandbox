variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  type    = string
  default = "us-west-1"
}

variable "dynamodb_table_name" {
  type    = string
  default = "edu-lohika-training-aws-dynamodb"
}

variable "rds_engine" {
  type    = string
  default = "postgres"
}

variable "rds_username" {
  type    = string
  default = "rootuser"
}

variable "rds_password" {
  type    = string
  default = "rootuser"
}

variable "rds_db_name" {
  type    = string
  default = "EduLohikaTrainingAwsRds"
}

variable "sns_topic_name" {
  type    = string
  default = "edu-lohika-training-aws-sns-topic"
}

variable "sqs_queue_name" {
  type    = string
  default = "edu-lohika-training-aws-sqs-queue"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_az" {
  type    = string
  default = "us-west-1a"
}

variable "private_subnet_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_az" {
  type    = string
  default = "us-west-1b"
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-08d9a394ac1c2994c"
}

variable "nat_ec2_ami_id" {
  type    = string
  default = "ami-004b0f60"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "rgederin-us-west-1"
}
