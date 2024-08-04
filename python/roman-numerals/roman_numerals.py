NUMBERS = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
LETTERS = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]


def roman(number: int) -> str:
    result = ""
    for value, letters in zip(NUMBERS, LETTERS):
        while number >= value:
            result += letters
            number -= value

    return result
