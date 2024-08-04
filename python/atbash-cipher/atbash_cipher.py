from string import ascii_lowercase

TABLE = str.maketrans(ascii_lowercase, ascii_lowercase[::-1])


def encode(plain_text: str) -> str:
    cipher = "".join(filter(str.isalnum, plain_text.lower())).translate(TABLE)
    return " ".join(cipher[n : n + 5] for n in range(0, len(cipher), 5))


def decode(ciphered_text: str) -> str:
    return "".join(filter(str.isalnum, ciphered_text.lower())).translate(TABLE)
