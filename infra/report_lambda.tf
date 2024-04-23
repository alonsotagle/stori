module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name  = "report"
  create_package = false
  create_role    = false
  lambda_role    = aws_iam_role.report_role.arn
  timeout        = 600

  image_uri    = "${aws_ecr_repository.report.repository_url}:latest"
  package_type = "Image"

  environment_variables = {
    TRANSACTIONS_TABLE = aws_dynamodb_table.transactions.name
    VERIFIED_EMAIL     = var.email
  }
}

resource "aws_iam_role" "report_role" {
  name               = "report_role"
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

resource "aws_iam_policy" "report_policy" {
  name = "report_policy"
  path = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action   = ["s3:GetObject", "s3:HeadObject"]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      },
      {
        Action   = ["dynamodb:Query", "dynamodb:Scan", "dynamodb:PutItem"]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.transactions.arn
      },
      {
        Action   = ["ses:SendEmail", "ses:SendTemplatedEmail"]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          StringEquals = {
            "ses:FromAddress" = var.email
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "report_attach_policy_role" {
  role       = aws_iam_role.report_role.name
  policy_arn = aws_iam_policy.report_policy.arn
}

resource "aws_s3_bucket_notification" "trigger" {
  bucket = aws_s3_bucket.bucket.id
  lambda_function {
    lambda_function_arn = module.lambda_function_container_image.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function_container_image.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.bucket.id}"
}
