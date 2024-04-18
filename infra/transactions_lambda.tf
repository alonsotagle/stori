module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "transactions"
  description   = "Create an upload transactions"
  handler       = "app.main"
  runtime       = "python3.10"

  source_path = "../transactions/src"

  create_role = false
  lambda_role = "arn:aws:iam::654654472464:role/tfc"

  environment_variables = {
    TRANSACTIONS_COUNT = "1000"
  }
}
