resource "aws_ses_template" "report_template" {
  name    = "report"
  subject = "Transactions Report"
  html    = "<h1>Transactions Report</h1><p>Total balance is {{balance}}.</p><ul>{{#each transactions}}<li>Number of transactions in {{month}}: {{count}}</li>{{/each}}</ul><p>Average debit amount: {{debit}}</p><p>Average credit amount: {{credit}}</p>"
}
