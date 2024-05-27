# -*- coding: utf-8 -*-
from datetime import datetime


class LedgerEntry:
    def __init__(self, date: str, description: str, change: int):
        self.date = datetime.strptime(date, "%Y-%m-%d")
        self.description = description
        self.change = change

    def __eq__(self, other) -> bool:
        return (self.date, self.change, self.description) == (other.date, other.change, other.description)

    def __lt__(self, other) -> bool:
        return (self.date, self.change, self.description) < (other.date, other.change, other.description)


def create_entry(date: str, description: str, change: int) -> LedgerEntry:
    return LedgerEntry(date, description, change)


class LedgerEntryFormatter:
    def __init__(self, date_hdr: str, descr_hdr: str, change_hdr: str):
        self.date_hdr = date_hdr
        self.descr_hdr = descr_hdr
        self.change_hdr = change_hdr

    def header(self) -> str:
        return f"{self.date_hdr:10} | {self.descr_hdr:25} | {self.change_hdr:13}"

    def description(self, description: str) -> str:
        return f"{description[:22]}..." if len(description) > 25 else description.ljust(25)


def format_entries(currency: str, locale: str, entries: list[LedgerEntry]) -> str:
    table = ""
    if locale == "en_US":
        formatter = LedgerEntryFormatter("Date", "Description", "Change")

        # Generate Header Row
        table += formatter.header()

        for entry in sorted(entries):
            table += "\n"

            # Write entry date to table
            table += entry.date.strftime("%m/%d/%Y") + " | "

            # Write entry description to table
            # Truncate if necessary
            table += formatter.description(entry.description) + " | "

            # Write entry change to table
            if currency == "USD":
                change_str = ""
                if entry.change < 0:
                    change_str = "("
                change_str += "$"
                change_dollar = abs(int(entry.change / 100.0))
                dollar_parts = []
                while change_dollar > 0:
                    dollar_parts.insert(0, str(change_dollar % 1000))
                    change_dollar = change_dollar // 1000
                if len(dollar_parts) == 0:
                    change_str += "0"
                else:
                    while True:
                        change_str += dollar_parts[0]
                        dollar_parts.pop(0)
                        if len(dollar_parts) == 0:
                            break
                        change_str += ","
                change_str += "."
                change_cents = abs(entry.change) % 100
                change_cents = str(change_cents)
                if len(change_cents) < 2:
                    change_cents = "0" + change_cents
                change_str += change_cents
                if entry.change < 0:
                    change_str += ")"
                else:
                    change_str += " "
                while len(change_str) < 13:
                    change_str = " " + change_str
                table += change_str
            elif currency == "EUR":
                change_str = ""
                if entry.change < 0:
                    change_str = "("
                change_str += "€"
                change_euro = abs(int(entry.change / 100.0))
                euro_parts = []
                while change_euro > 0:
                    euro_parts.insert(0, str(change_euro % 1000))
                    change_euro = change_euro // 1000
                if len(euro_parts) == 0:
                    change_str += "0"
                else:
                    while True:
                        change_str += euro_parts[0]
                        euro_parts.pop(0)
                        if len(euro_parts) == 0:
                            break
                        change_str += ","
                change_str += "."
                change_cents = abs(entry.change) % 100
                change_cents = str(change_cents)
                if len(change_cents) < 2:
                    change_cents = "0" + change_cents
                change_str += change_cents
                if entry.change < 0:
                    change_str += ")"
                else:
                    change_str += " "
                while len(change_str) < 13:
                    change_str = " " + change_str
                table += change_str
    elif locale == "nl_NL":
        formatter = LedgerEntryFormatter("Datum", "Omschrijving", "Verandering")

        # Generate Header Row
        table += formatter.header()

        for entry in sorted(entries):
            table += "\n"

            # Write entry date to table
            table += entry.date.strftime("%d-%m-%Y") + " | "

            # Write entry description to table
            # Truncate if necessary
            table += formatter.description(entry.description) + " | "

            # Write entry change to table
            if currency == "USD":
                change_str = "$ "
                if entry.change < 0:
                    change_str += "-"
                change_dollar = abs(int(entry.change / 100.0))
                dollar_parts = []
                while change_dollar > 0:
                    dollar_parts.insert(0, str(change_dollar % 1000))
                    change_dollar = change_dollar // 1000
                if len(dollar_parts) == 0:
                    change_str += "0"
                else:
                    while True:
                        change_str += dollar_parts[0]
                        dollar_parts.pop(0)
                        if len(dollar_parts) == 0:
                            break
                        change_str += "."
                change_str += ","
                change_cents = abs(entry.change) % 100
                change_cents = str(change_cents)
                if len(change_cents) < 2:
                    change_cents = "0" + change_cents
                change_str += change_cents
                change_str += " "
                while len(change_str) < 13:
                    change_str = " " + change_str
                table += change_str
            elif currency == "EUR":
                change_str = "€ "
                if entry.change < 0:
                    change_str += "-"
                change_euro = abs(int(entry.change / 100.0))
                euro_parts = []
                while change_euro > 0:
                    euro_parts.insert(0, str(change_euro % 1000))
                    change_euro = change_euro // 1000
                if len(euro_parts) == 0:
                    change_str += "0"
                else:
                    while True:
                        change_str += euro_parts[0]
                        euro_parts.pop(0)
                        if len(euro_parts) == 0:
                            break
                        change_str += "."
                change_str += ","
                change_cents = abs(entry.change) % 100
                change_cents = str(change_cents)
                if len(change_cents) < 2:
                    change_cents = "0" + change_cents
                change_str += change_cents
                change_str += " "
                while len(change_str) < 13:
                    change_str = " " + change_str
                table += change_str

    return table
