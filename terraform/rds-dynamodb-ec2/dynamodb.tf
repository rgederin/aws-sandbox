resource "aws_dynamodb_table" "dynamo_db_table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LookupKey"

  attribute {
    name = "LookupKey"
    type = "N"
  }
}
