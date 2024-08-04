from functools import reduce


def largest_product(series: str, size: int) -> int:
    if size > len(series):
        raise ValueError("span must be smaller than string length")

    if size < 0:
        raise ValueError("span must not be negative")

    if not series.isdigit():
        raise ValueError("digits input must only contain digits")

    return max(reduce(lambda acc, n: acc * int(n), series[k : k + size], 1) for k in range(len(series) - size + 1))
