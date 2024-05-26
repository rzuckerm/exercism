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


def format_entries(currency: str, locale: str, entries: list[LedgerEntry]) -> str:
    table = ""
    if locale == "en_US":
        # Generate Header Row
        table += "Date"
        for _ in range(7):
            table += " "
        table += "| Description"
        for _ in range(15):
            table += " "
        table += "| Change"
        for _ in range(7):
            table += " "

        for entry in sorted(entries):
            table += "\n"

            # Write entry date to table
            table += entry.date.strftime("%m/%d/%Y") + " | "

            # Write entry description to table
            # Truncate if necessary
            if len(entry.description) > 25:
                for i in range(22):
                    table += entry.description[i]
                table += "..."
            else:
                for i in range(25):
                    if len(entry.description) > i:
                        table += entry.description[i]
                    else:
                        table += " "
            table += " | "

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
        # Generate Header Row
        table += "Datum"
        for _ in range(6):
            table += " "
        table += "| Omschrijving"
        for _ in range(14):
            table += " "
        table += "| Verandering"
        for _ in range(2):
            table += " "

        for entry in sorted(entries):
            table += "\n"

            # Write entry date to table
            table += entry.date.strftime("%d-%m-%Y") + " | "

            # Write entry description to table
            # Truncate if necessary
            if len(entry.description) > 25:
                for i in range(22):
                    table += entry.description[i]
                table += "..."
            else:
                for i in range(25):
                    if len(entry.description) > i:
                        table += entry.description[i]
                    else:
                        table += " "
            table += " | "

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
