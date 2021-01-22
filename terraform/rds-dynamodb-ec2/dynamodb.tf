resource "aws_dynamodb_table" "course-trainers-dynamo-db" {
  name           = "course-trainers-dynamo-db"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LookupKey"


  attribute {
    name = "LookupKey"
    type = "N"
  }
}
