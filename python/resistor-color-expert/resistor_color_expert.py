BANDS = {
    "black": (0, 0),
    "brown": (1, 1),
    "red": (2, 2),
    "orange": (3, 0),
    "yellow": (4, 0),
    "green": (5, 0.5),
    "blue": (6, 0.25),
    "violet": (7, 0.1),
    "grey": (8, 0.05),
    "white": (9, 0),
    "gold": (0, 5),
    "silver": (0, 10),
}

UNITS_DIVISORS = [
    ("", 1),
    ("kilo", 1_000),
    ("mega", 1_000_000),
    ("giga", 1_000_000_000),
]


def resistor_label(colors: list[str]) -> str:
    if len(colors) == 1:
        return f"{BANDS[colors[0]][0]} ohms"

    value = (
        sum(BANDS[color][0] * 10**n for n, color in enumerate(reversed(colors[:-2])))
        * 10 ** BANDS[colors[-2]][0]
    )
    for unit, divisor in UNITS_DIVISORS:
        if value < 1000 * divisor:
            value = value // divisor if value % divisor == 0 else value / divisor
            return f"{value} {unit}ohms ±{BANDS[colors[-1]][1]}%"

    return ""
