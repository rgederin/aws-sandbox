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

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
