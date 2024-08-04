def factors(value: int) -> list[int]:
    result = []
    factor = 2
    while factor * factor <= value:
        while value % factor == 0:
            result.append(factor)
            value //= factor

        factor += 1 if factor == 2 else 2

    return result if value < 2 else result + [value]
