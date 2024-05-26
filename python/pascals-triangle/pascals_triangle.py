def rows(row_count: int, result=None) -> list[list[int]]:
    if row_count < 0:
        raise ValueError("number of rows is negative")

    result = result or ([[1]] if row_count else [])
    if row_count < 2:
        return result

    return rows(row_count - 1, result + [[x + y for x, y in zip([0] + result[-1], result[-1] + [0])]])
