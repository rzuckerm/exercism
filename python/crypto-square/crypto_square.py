from math import ceil, sqrt


def cipher_text(plain_text: str) -> str:
    cleaned_text = "".join(ch for ch in plain_text.lower() if ch.isalnum())
    r, c = round(q := sqrt(len(cleaned_text))), ceil(q)
    return " ".join(cleaned_text[x::c].ljust(r) for x in range(c)) if c else ""
