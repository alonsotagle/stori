# Stori - Transaction Processor

This project provides a solution for processing a file containing debit and credit transactions on an account and sending summary information to a user via email.

## Overview

The system consists of a script written in Python that processes the transaction file. It identifies debit and credit transactions based on the presence of a minus (-) or plus (+) sign, respectively. Summary information is then extracted and sent to the user via email.

![Arch diagram](arch.png?raw=true "Arch diagram")

## Technologies Used
- Python
- Pytest
- Pandas
- Boto3
- Terraform
- Docker
- Github Actions

## AWS services
- S3
- Lambda
- DynamoDB
- SES
- IAM
- CloudWatch

## Contact
For any inquiries or feedback, please contact dev@alonsotagle.com


## TASKS

### INFRA
- [x] Create infra dir
- [x] Link Terraform Cloud
- [x] Create terraform S3 bucket
- [x] Create transactions lambda
- [x] Create report lambda
- [x] Create CI/CD pipeline with Github Actions

### TRANSACTIONS

- [x] Create transactions dir
- [x] Generate transactions file
- [x] Upload transactions file to S3

### REPORT
- [x] Create report dir
- [x] Dowload transactions file from S3
- [x] Read file with pandas from S3
- [x] Read data with pandas
- [x] Analyze data with pandas
- [x] Store transactions in DynamoDB
- [x] Package in docker image
- [x] Create SES template
- [x] Send email
- [x] Test email
- [x] Style email
- [ ] Invoke report lambda by HTTP request
