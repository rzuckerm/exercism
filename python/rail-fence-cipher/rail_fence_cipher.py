from itertools import cycle


def encode(message: str, rails: int) -> str:
    return "".join(message[i] for i in _indices(rails, len(message)))


def decode(encoded_message: str, rails: int) -> str:
    chunks = zip(_indices(rails, len(encoded_message)), encoded_message)
    return "".join(ch for _, ch in sorted(chunks))


def _indices(rails: int, size: int) -> list[int]:
    return [idx for _, idx in sorted(zip(cycle(list(range(0, rails)) + list(range(rails - 2, 0, -1))), range(size)))]
