COLORS = {
    "black": 0,
    "brown": 1,
    "red": 2,
    "orange": 3,
    "yellow": 4,
    "green": 5,
    "blue": 6,
    "violet": 7,
    "grey": 8,
    "white": 9,
}

UNITS_DIVISORS = [
    ("", 1),
    ("kilo", 1_000),
    ("mega", 1_000_000),
    ("giga", 1_000_000_000),
]


def label(colors: list[str]) -> str:
    value = (10 * COLORS[colors[0]] + COLORS[colors[1]]) * 10 ** COLORS[colors[2]]
    for unit, divisor in UNITS_DIVISORS:
        if value < 1000 * divisor:
            return f"{value // divisor} {unit}ohms"

    return ""
