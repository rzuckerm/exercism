def annotate(garden):
    if any(len(row) != len(garden[0]) or any(ch not in " *" for ch in row) for row in garden):
        raise ValueError("The board is invalid with current input.")

    return [_get_row(garden, r) for r in range(len(garden))]


def _get_row(garden: list[str], r: int) -> str:
    return "".join(ch if ch == "*" else str(_get_sum(garden, r, c) or " ") for c, ch in enumerate(garden[r]))


def _get_sum(garden: list[str], r: int, c: int) -> int:
    return sum(_is_flower(garden, r2, c2) for r2 in range(r - 1, r + 2) for c2 in range(c - 1, c + 2))


def _is_flower(garden: list[str], r: int, c: int) -> int:
    return int(0 <= r < len(garden) and 0 <= c < len(garden[r]) and garden[r][c] == "*")
