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

    def change_en_us(self, curr_symbol: str, change: int) -> str:
        change = change / 100
        return (f"({curr_symbol}{-change:,.2f})" if change < 0 else f"{curr_symbol}{change:,.2f} ").rjust(13)

    def change_nl_nl(self, curr_symbol: str, change: int) -> str:
        change = change / 100
        return f"{curr_symbol} {change:,.2f} ".replace(",", ":").replace(".", ",").replace(":", ".").rjust(13)


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
            table += formatter.change_en_us("$" if currency == "USD" else "€", entry.change)
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
            table += formatter.change_nl_nl("$" if currency == "USD" else "€", entry.change)

    return table
