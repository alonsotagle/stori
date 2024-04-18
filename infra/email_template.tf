resource "aws_ses_template" "report_template" {
  name    = "report"
  subject = "Transactions Report"
  html    = "<h1>Transactions Report</h1><header><img src='https://es.wikipedia.org/wiki/Stori_%28Tarjeta_de_cr%C3%A9dito%29#/media/Archivo:Stori_Logo_2023.svg' alt="Stori"/></header><p>Total balance is {{balance}}.</p><ul>{{#each transactions}}<li>Number of transactions in {{month}}: {{count}}</li>{{/each}}</ul><p>Average debit amount: {{debit}}</p><p>Average credit amount: {{credit}}</p>"
}
