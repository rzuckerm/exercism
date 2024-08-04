def is_valid(isbn: str) -> bool:
    isbn = "".join(reversed(isbn.replace("-", "")))
    if len(isbn) == 10 and isbn[1:].isdecimal() and isbn[0] in "0123456789X":
        total = sum((ch == "X" and 10 or int(ch)) * n for n, ch in enumerate(isbn, 1))
        return total % 11 == 0

    return False
