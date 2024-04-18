# import boto3
import random

from csv import DictWriter
from datetime import datetime, timedelta
from os import environ
from tempfile import NamedTemporaryFile
from time import time_ns


def main(event, context):
    file_path = generate_transactions()
    return upload_transactions_file(file_path)


def get_random_datetime() -> str:
    random_date = datetime.now() + timedelta(days=random.randint(0, 365))
    return random_date.strftime("%m/%d")


def generate_transactions() -> str:

    with NamedTemporaryFile(mode="w", delete=False) as temp_file:

        file_writer = DictWriter(temp_file, fieldnames=["Id", "Date", "Transaction"])
        file_writer.writeheader()

        for i in range(environ.get("TRANSACTIONS_COUNT", 1000)):
            row = {
                "Id": i,
                "Date": get_random_datetime(),
                "Transaction": f"{random.choice(['+', '-'])}{round(random.uniform(10, 100), 2)}"
            }

            file_writer.writerow(row)

        return temp_file.name


def upload_transactions_file(file_path: str):
    return print(file_path)
    s3_client = boto3.client("s3")
    s3_client.upload_file(file_path, environ.get("TRANSACTIONS_BUCKET", "test"), f"{time_ns()}.csv")
    return "Transaction uploaded successfully!"


if __name__ == '__main__':
    main()
