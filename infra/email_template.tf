resource "aws_ses_template" "report_template" {
  name    = "report"
  subject = "Transactions Report"
  html    = "<header><img src='https://report-transactions.s3.us-east-1.amazonaws.com/stori.png?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEBkaCXVzLWVhc3QtMSJIMEYCIQCpHQ6o1jtwWA40a1CcNDJ92z4R%2FvqXYFbC%2BFwzmQaDswIhAKqRPMFGa7hyVfaYx8EoFTpI1AEAGxRcCKpWWiuPIXpDKvMDCGIQABoMNjU0NjU0NDcyNDY0IgxY3WGxcgXDD%2FaOkUkq0AMndyEepYmTVvOpGvl6HhD96agdYT1YavdmKn%2BSiVN8rBPppJc5Ku1fNs%2FAUBu9pkh3%2BJVWqozkKhsJqGT1LVJKJjNHrlSWZ8jjvz025KhA0wZYX3IvTzsvLBskLVClQzHZrVlR%2F%2Bvjs27jXqqGyQqcIdzzxvaZdD75kr9ibX7W1zEcaB%2FJKLhHbxOItnk012bpbMFgwlDwKT%2BCy7pvd%2B0S3yHcw8hJK0%2F8J4F9erZ0%2Bc1RtshTehJab9nYPaq1f3A3gxNCjbiBCkoGbSkWDEcLD3LHNopUxK5xRl7GP7qCTQIKpGLcSz3rNUJs%2FqCNIOSLNSmblIiJeD%2FH5PNNpxmj2Vc%2Bz%2FG%2FfVkftc8qabA6iAJWBUuNoRL%2Bzj2bx%2BoArsQ1xZPrGhOmuH9noirf8lQuFmrmdiUiDK8WwYKl8USzMSX%2B0fX9feNPcOGy%2BzsyJaoiaGVwebM4SA1nkY74ccksXto2wfon4usvKvtkLKsfKGBDQrI7fDFanREZtBeTT%2F0qwAuxS44BCoxyfVtGu0tbo9g3SG4rVt450a8M7a7anbuXzUpQdR176sfh6Md%2FR%2BxkPa4lPROgGgUH2qqnKY4LtyUoxj8Q455VSN%2BdvZap4zDvn5qxBjqTAkJ2AV00Kj1cH8ND0khXy%2BZZgsDgev%2BFJNQuoHVDcLg4Bd6WCh7s1%2Bc7PLR5PUV%2BBJdSXtOdwL5SrSiKctmzf4d4y2FukQwsUNnnN47J6UWlf%2B53%2BGne8EusIolY5GxafsSZhU3mTqobUxdwFwNPUCvr%2BCpDqGY1XHCsd1G6ot4ctSWq7xVsh827RYAx8qzSr5iqgYFEm6%2FEPT9E4T0YZCRvukdIX%2BWme67hAZBZyqAVx1sG94nX72IIGjK4U8hnCuMGzf0Ba31g2NyT35FKpEwhA0UyABnGVrclnlk6tktFKwsocryFSWtykIiWRp%2FHabe%2F6FR%2BpGZACsLt9TANnv3DnQWgm4R0%2Brtw69GzUBoa85lb&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240422T165100Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIAZQ3DSQEIDNFMCKI7%2F20240422%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=476d9c84a37fe01e21ac63933ebab5ca531b3aa010e47f73797b4dc9fd3eaf49' alt='Stori'/><h1>Transactions Report</h1></header><br><p>Total balance is <b>{{balance}}</b></p><ul>{{#each transactions}}<li>Number of transactions in <b>{{month}}</b>: <b>{{count}}</b></li>{{/each}}</ul><p>Average debit amount: <b>{{debit}}</b></p><p>Average credit amount: <b>{{credit}}</b></p><br><p><a href='{{url}}'>File analyzed</a></p>"
  text    = "Total balance is {{balance}}\n\n{{#each transactions}}Number of transactions in {{month}}: {{count}}\n{{/each}}\nAverage debit amount: {{debit}}\nAverage credit amount: {{credit}}\n\n{{url}}"
}

variable "email" {
  description = "The email address to create a new SES identity for"
  type        = string
  default     = "hire@alonsotagle.com"
}

resource "aws_ses_email_identity" "example" {
  email = var.email
}
