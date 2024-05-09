FIRST_10 = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
TEENS = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
MULTIPLES_OF_10 = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
POWERS = {(int(1e9), 1000): "billion", (int(1e6), 1000): "million", (1000, 1000): "thousand", (100, 10): "hundred"}


def say(number: int) -> str:
    if number < 0 or number > 999_999_999_999:
        raise ValueError("input out of range")

    if number < 20:
        return (FIRST_10 + TEENS)[number]

    if number < 100:
        return MULTIPLES_OF_10[number // 10] + ("" if (x := number % 10) == 0 else f"-{FIRST_10[x]}")

    vals_words = [((number // d) % m, f" {word}") for (d, m), word in POWERS.items()] + [(number % 100, "")]
    return " ".join(f"{say(val)}{word}" for val, word in vals_words if val)
