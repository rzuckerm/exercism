from itertools import cycle
from string import ascii_lowercase
from typing import Callable
import secrets


class Cipher:
    def __init__(self, key: str = None):
        self.key = key or "".join(secrets.choice(ascii_lowercase) for _ in range(100))

    def encode(self, text: str) -> str:
        return self._translate(lambda a, b: a + b - 2 * ord("a"), text)

    def decode(self, text: str) -> str:
        return self._translate(lambda a, b: a - b, text)

    def _translate(self, func: Callable[[int, int], int], text: str) -> str:
        return "".join(chr(func(ord(ch), ord(k)) % 26 + ord("a")) for ch, k in zip(text, cycle(self.key)))
