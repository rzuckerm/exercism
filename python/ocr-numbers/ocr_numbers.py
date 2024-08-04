OCR_NUMBERS = [
    " _     _  _     _  _  _  _  _ ",
    "| |  | _| _||_||_ |_   ||_||_|",
    "|_|  ||_  _|  | _||_|  ||_| _|",
    "                              ",
]


def convert(input_grid: list[str]) -> str:
    if len(input_grid) % 4:
        raise ValueError("Number of input lines is not a multiple of four")

    if any(len(row) % 3 for row in input_grid):
        raise ValueError("Number of input columns is not a multiple of three")

    return ",".join(
        "".join(_convert_cell(input_grid, r, c) for c in range(0, len(input_grid[r]), 3))
        for r in range(0, len(input_grid), 4)
    )


def _convert_cell(input_grid: list[str], r: int, c: int) -> str:
    for n in range(10):
        if all(input_grid[r + k][c : c + 3] == OCR_NUMBERS[k][n * 3 : n * 3 + 3] for k in range(4)):
            return str(n)

    return "?"
