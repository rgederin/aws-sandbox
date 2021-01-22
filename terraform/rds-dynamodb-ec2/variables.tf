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

variable "key_name" {
  description = "EC2 instance ssh key"
  type        = string
  default     = "rgederin-us-west-1"
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket from where file should be downloaded"
  type        = string
  default     = "rgederin-bucket"
}

variable "s3_file_key" {
  description = "Name of the file in S3 bucket which should be downloaded"
  type        = string
  default     = "rgederin-s3-file.txt"
}

variable "destination_file_name" {
  description = "Name of the file in EC2 instance"
  type        = string
  default     = "rgederin-s3-file.txt"
}
