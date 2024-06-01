from typing import Callable

INVERSES = [1, 9, 21, 15, 3, 19, 0, 7, 23, 11, 5, 17, 25]


def encode(plain_text: str, a: int, b: int) -> str:
    ciphered_text = _mutate_text(plain_text, a, lambda x: a * x + b)
    return " ".join(ciphered_text[idx : idx + 5] for idx in range(0, len(ciphered_text), 5))


def decode(ciphered_text: str, a: int, b: int) -> str:
    return _mutate_text(ciphered_text, a, lambda x: INVERSES[a // 2] * (x - b))


def _mutate_text(text: str, a: int, func: Callable[[int], int]) -> str:
    if a % 2 == 0 or a % 13 == 0:
        raise ValueError("a and m must be coprime.")

    return "".join(ch if ch.isdigit() else chr(func(ord(ch) - 97) % 26 + 97) for ch in text.lower() if ch.isalnum())
