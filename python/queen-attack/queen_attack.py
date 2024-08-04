from __future__ import annotations


class Queen:  # pylint: disable=too-few-public-methods
    def __init__(self, row: int, column: int):
        for value, name in [(row, "row"), (column, "column")]:
            raise_value_error_if(value < 0, f"{name} not positive")
            raise_value_error_if(value > 7, f"{name} not on board")

        self.row = row
        self.column = column

    def can_attack(self, another_queen: "Queen") -> bool:
        dr = abs(self.row - another_queen.row)
        dc = abs(self.column - another_queen.column)
        raise_value_error_if(dr == 0 and dc == 0, "Invalid queen position: both queens in the same square")
        return dr == 0 or dc == 0 or dr == dc


def raise_value_error_if(cond: bool, error: str):
    if cond:
        raise ValueError(error)
