def encode(numbers: list[int]) -> list[int]:
    return sum((_encode_number(number) for number in numbers), [])


def _encode_number(number: int) -> list[int]:
    return [((number >> n) & 0x7F) | (0x80 if n else 0) for n in reversed(range(0, max(number.bit_length(), 1), 7))]


def decode(bytes_: list[int]) -> list[int]:
    if bytes_ and bytes_[-1] & 0x80:
        raise ValueError("incomplete sequence")

    result = []
    number = 0
    for b in bytes_:
        number = (number << 7) | (b & 0x7F)
        if not b & 0x80:
            result.append(number)
            number = 0

    return result
