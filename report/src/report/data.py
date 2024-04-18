import boto3
import json
import pandas as pd

from os import environ
from tempfile import NamedTemporaryFile


def download_transactions_file(event: dict) -> str:

    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = event["Records"][0]["s3"]["object"]["key"]

    s3 = boto3.client("s3")
    with NamedTemporaryFile() as f:
        s3.download_fileobj(bucket, key, f)

    return f.name


def analyze_data(filename: str) -> dict:

    df = pd.read_csv(filename)

    df["Date"] = pd.to_datetime(df["Date"], format="%m/%d")

    by_month = df.groupby(pd.Grouper(key="Date", axis=0, freq="1ME", sort=True)).count()

    return {
        "balance": df.Transaction.sum().round(2),
        "credit": df[df.Transaction > 0].Transaction.mean().round(2),
        "debit": df[df.Transaction < 0].Transaction.mean().round(2),
        "transactions": [
            {
                "count": count,
                "month": month.strftime("%B"),
            } for month, count in by_month.Transaction.items()
        ],
    }


def store_transactions(filename: str):

    transactions = json.loads(pd.read_csv(filename).to_json(orient="records"))

    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table(environ.get("TRANSACTIONS_TABLE"))
    
    for record in transactions:
        table.put_item(Item=record)
