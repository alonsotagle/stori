resource "aws_dynamodb_table" "transactions" {
  name         = "transactions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Id"

  attribute {
    name = "Id"
    type = "N"
  }
}
