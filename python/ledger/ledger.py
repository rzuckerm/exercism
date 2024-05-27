# -*- coding: utf-8 -*-
from datetime import datetime


def change_en(curr_symbol: str, change: float) -> str:
    return (f"({curr_symbol}{-change:,.2f})" if change < 0 else f"{curr_symbol}{change:,.2f} ").rjust(13)


def change_nl(curr_symbol: str, change: int) -> str:
    return f"{curr_symbol} {change:_.2f} ".replace(".", ",").replace("_", ".").rjust(13)


LEDGER_FORMAT = {
    "en_US": {"header": ("Date", "Description", "Change"), "date_fmt": "%m/%d/%Y", "change_func": change_en},
    "nl_NL": {"header": ("Datum", "Omschrijving", "Verandering"), "date_fmt": "%d-%m-%Y", "change_func": change_nl},
}
CURR_SYMBOLS = {"USD": "$", "EUR": "€"}


class LedgerEntry:
    def __init__(self, date: str, description: str, change: int):
        self.date = datetime.strptime(date, "%Y-%m-%d")
        self.description = description
        self.change = change / 100


create_entry = LedgerEntry  # pylint: disable=invalid-name


def format_entries(currency: str, locale: str, entries: list[LedgerEntry]) -> str:
    ledger_format = LEDGER_FORMAT[locale]
    table = [" | ".join(hdr.ljust(size) for hdr, size in zip(ledger_format["header"], [10, 25, 13]))] + [
        " | ".join(
            [
                entry.date.strftime(ledger_format["date_fmt"]),
                f"{entry.description[:22]}..." if len(entry.description) > 25 else entry.description.ljust(25),
                ledger_format["change_func"](CURR_SYMBOLS[currency], entry.change),
            ]
        )
        for entry in sorted(entries, key=lambda x: (x.date, x.change, x.description))
    ]
    return "\n".join(table)
