import boto3

from json import dumps
from os import environ


def send_report(data: dict) -> None:

    ses = boto3.client("ses")

    ses.send_templated_email(
        Source=environ.get("VERIFIED_EMAIL"),
        Destination={
            "ToAddresses": [environ.get("VERIFIED_EMAIL")],
            "CcAddresses": []
        },
        ReplyToAddresses=[environ.get("VERIFIED_EMAIL")],
        Template="report",
        TemplateData=dumps(data)
    )
