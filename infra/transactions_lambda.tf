module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "transactions"
  description   = "Create an upload transactions"
  handler       = "app.main"
  runtime       = "python3.12"
  timeout       = 30

  source_path = "../transactions/src"

  create_role = false
  lambda_role = aws_iam_role.transactions_role.arn

  environment_variables = {
    TRANSACTIONS_COUNT  = "1000"
    TRANSACTIONS_BUCKET = aws_s3_bucket.bucket.id
  }
}

resource "aws_iam_role" "transactions_role" {
  name               = "transactions_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "transactions_policy" {
  name   = "transactions_policy"
  path   = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::report-transactions/*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_policy_role" {
  role       = aws_iam_role.transactions_role.name
  policy_arn = aws_iam_policy.transactions_policy.arn
}
