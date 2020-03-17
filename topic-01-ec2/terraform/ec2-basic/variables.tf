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
