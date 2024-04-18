import data
import pathlib

from data import analyze_data


def test_analyze_data(monkeypatch, request):
    path = pathlib.Path(request.node.fspath)
    sample_file = path.with_name("sample.csv")

    monkeypatch.setattr(data, "download_transactions_file", lambda *args, **kwargs: sample_file)

    result = analyze_data(sample_file)

    assert isinstance(result, dict)
    assert "balance" in result
    assert "credit" in result
    assert "debit" in result
    assert "transactions" in result
    assert result == {
        "balance": 1660.01,
        "credit": 56.3,
        "debit": -53.86,
        "transactions": [
            {"count": 95, "month": "January"},
            {"count": 73, "month": "February"},
            {"count": 75, "month": "March"},
            {"count": 95, "month": "April"},
            {"count": 93, "month": "May"},
            {"count": 93, "month": "June"},
            {"count": 78, "month": "July"},
            {"count": 83, "month": "August"},
            {"count": 72, "month": "September"},
            {"count": 83, "month": "October"},
            {"count": 88, "month": "November"},
            {"count": 72, "month": "December"}
        ]
    }
