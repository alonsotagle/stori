from data import analyze_data, download_transactions_file, store_transactions
from ses_email import send_report


def main(event, context):
    filename = download_transactions_file(event)
    store_transactions(filename)

    data = analyze_data(filename)
    send_report(data)
