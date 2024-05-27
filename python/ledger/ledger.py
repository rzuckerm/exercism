# -*- coding: utf-8 -*-
from datetime import datetime


class LedgerEntry:
    def __init__(self, date: str, description: str, change: int):
        self.date = datetime.strptime(date, "%Y-%m-%d")
        self.description = description
        self.change = change / 100

    def __eq__(self, other) -> bool:
        return (self.date, self.change, self.description) == (other.date, other.change, other.description)

    def __lt__(self, other) -> bool:
        return (self.date, self.change, self.description) < (other.date, other.change, other.description)


def create_entry(date: str, description: str, change: int) -> LedgerEntry:
    return LedgerEntry(date, description, change)


class LedgerEntryFormatter:
    def __init__(self, currency: str, locale: str):
        self.curr_symbol = "$" if currency == "USD" else "€"
        if locale == "en_US":
            self.date_hdr, self.descr_hdr, self.change_hdr = "Date", "Description", "Change"
            self.date_format = "%m/%d/%Y"
            self.change_func = self.change_en
        else:
            self.date_hdr, self.descr_hdr, self.change_hdr = "Datum", "Omschrijving", "Verandering"
            self.date_format = "%d-%m-%Y"
            self.change_func = self.change_nl

    def header(self) -> str:
        return f"{self.date_hdr:10} | {self.descr_hdr:25} | {self.change_hdr:13}"

    def date_(self, date: datetime) -> str:
        return date.strftime(self.date_format)

    def description(self, description: str) -> str:
        return f"{description[:22]}..." if len(description) > 25 else description.ljust(25)

    def change_en(self, change: int) -> str:
        return (f"({self.curr_symbol}{-change:,.2f})" if change < 0 else f"{self.curr_symbol}{change:,.2f} ").rjust(13)

    def change_nl(self, change: int) -> str:
        return f"{self.curr_symbol} {change:,.2f} ".replace(",", ":").replace(".", ",").replace(":", ".").rjust(13)


def format_entries(currency: str, locale: str, entries: list[LedgerEntry]) -> str:
    # Generate Header Row
    formatter = LedgerEntryFormatter(currency, locale)
    table = [formatter.header()]
    for entry in sorted(entries):
        # Write entry date to table
        line = formatter.date_(entry.date) + " | "

        # Write entry description to table
        # Truncate if necessary
        line += formatter.description(entry.description) + " | "

        # Write entry change to table
        line += formatter.change_func(entry.change)
        table.append(line)

    return "\n".join(table)
