variable "rds_engine" {
  description = "Engine using by RDS"
  type        = string
}

variable "rds_db_name" {
  description = "Database name for RDS instance"
  type        = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}
