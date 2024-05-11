class Luhn:  # pylint: disable=too-few-public-methods
    def __init__(self, card_num: str):
        self.digits = [int(ch) if ch.isdigit() else -1 for ch in card_num.replace(" ", "")]

    def valid(self) -> bool:
        if any(d < 0 for d in self.digits) or len(self.digits) < 2:
            return False

        return sum(2 * (d % 5) + d // 5 if n % 2 else d for n, d in enumerate(self.digits[::-1])) % 10 == 0
