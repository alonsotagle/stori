import boto3
import json


def send_report(data: dict):

    ses = boto3.client("ses")

    response = ses.send_templated_email(
        Source="alonsotaglecom@gmail.com",
        Destination={
            "ToAddresses": ["alonsotaglecom+stori@gmail.com"],
            "CcAddresses": []
        },
        ReplyToAddresses=["alonsotaglecom@gmail.com"],
        Template="report",
        TemplateData=json.dumps(data)
    )

    print(response)
