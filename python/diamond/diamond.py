def rows(letter: str) -> list[str]:
    n = ord(letter) - ord("A")
    letters = [chr(ord("A") + abs(k)) for k in range(-n, n + 1)]
    return ["".join(x if x == y else " " for x in letters) for y in letters[n:] + letters[1 : n + 1]]
