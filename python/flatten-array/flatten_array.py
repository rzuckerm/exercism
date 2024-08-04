def flatten(iterable: list) -> list:
    output = (
        flatten(x) if isinstance(x, list) else [x] for x in iterable if x is not None
    )
    return sum(output, [])
