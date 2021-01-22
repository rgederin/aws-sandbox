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

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "course-trainers-dynamo-db"
}

variable "rds_engine" {
  description = "Engine using by RDS"
  type        = string
  default     = "postgres"
}

variable "rds_username" {
  description = "Username for RDS instance"
  type        = string
  default     = "postgres"
}

variable "rds_password" {
  description = "Password for RDS instance"
  type        = string
  default     = "postgres"
  # sensitive   = true
}

variable "s3_bucket_name" {
  description = "Name of S3 bucket from where file should be downloaded"
  type        = string
  default     = "rgederin-bucket-week3"
}

variable "s3_sql_script_file_name" {
  description = "Name of the SQL script in S3"
  type        = string
  default     = "rds-script.sql"
}

variable "s3_dynamodb_script_file_name" {
  description = "Name of the DynamoDb script in S3"
  type        = string
  default     = "dynamodb-script.sh"
}
