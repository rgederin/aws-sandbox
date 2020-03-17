variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-0a887e401f7654935"
  }
}

variable "EC2_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "rgederin-aws-key-pair.pem"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "rgederin-aws-key-pair"
}

variable "EC2_INSTANTCE_USERNAME" {
  default = "ec2-user"
}