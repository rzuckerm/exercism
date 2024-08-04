def slices(series: str, length: int) -> list[str]:
    if not length:
        raise ValueError("slice length cannot be zero")

    if length < 0:
        raise ValueError("slice length cannot be negative")

    if not series:
        raise ValueError("series cannot be empty")

    if len(series) < length:
        raise ValueError("slice length cannot be greater than series length")

    return [series[n : n + length] for n in range(len(series) - length + 1)]
