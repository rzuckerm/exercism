from string import ascii_lowercase as al, ascii_uppercase as au


def rotate(text: str, key: int) -> str:
    table = {ord(x[n]): ord(x[(n + key) % 26]) for x in [al, au] for n in range(26)}
    return text.translate(table)
