def annotate(minefield: list[str]) -> list[str]:
    if any(len(row) != len(minefield[0]) or any(ch not in " *" for ch in row) for row in minefield):
        raise ValueError("The board is invalid with current input.")

    return [_get_row(minefield, r) for r in range(len(minefield))]


def _get_row(minefield: list[str], r: int) -> str:
    return "".join(ch if ch == "*" else str(_get_sum(minefield, r, c) or " ") for c, ch in enumerate(minefield[r]))


def _get_sum(minefield: list[str], r: int, c: int) -> int:
    return sum(_is_mine(minefield, r2, c2) for r2 in range(r - 1, r + 2) for c2 in range(c - 1, c + 2))


def _is_mine(minefield: list[str], r: int, c: int) -> int:
    return int(0 <= r < len(minefield) and 0 <= c < len(minefield[r]) and minefield[r][c] == "*")
