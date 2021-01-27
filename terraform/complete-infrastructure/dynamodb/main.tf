resource "aws_dynamodb_table" "username_dynamodb_table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserName"

  attribute {
    name = "UserName"
    type = "S"
  }
}
