resource "aws_ecr_repository" "report" {
  name = "transactions-report"

  image_scanning_configuration {
    scan_on_push = true
  }
}
