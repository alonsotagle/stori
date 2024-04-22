import boto3
import json


def send_report(data: dict):

    ses = boto3.client("ses")

    response = ses.send_templated_email(
        Source="hire@alonsotagle.com",
        Destination={
            "ToAddresses": ["hire@alonsotagle.com"],
            "CcAddresses": []
        },
        ReplyToAddresses=["hire@alonsotagle.com"],
        Template="report",
        TemplateData=json.dumps(data)
    )

    print(response)
