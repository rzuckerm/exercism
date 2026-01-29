ORDINALS = {1: "st", 2: "nd", 3: "rd"}


def line_up(name, number):
    ordinal = ORDINALS.get(number % 10 if (number % 100) not in (11, 12, 13) else 0, "th")
    return f"{name}, you are the {number}{ordinal} customer we serve today. Thank you!"
