import re


def decode(string: str) -> str:
    return re.sub(r"(\d+)(\D)", lambda m: m.group(2) * int(m.group(1)), string)


def encode(string: str) -> str:
    return re.sub(r"(.)\1+", lambda m: f"{len(m.group(0))}{m.group(1)}", string)
