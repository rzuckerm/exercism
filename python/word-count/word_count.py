import re
from collections import Counter


def count_words(sentence: str) -> dict[str, str]:
    return dict(Counter(re.findall(r"[a-z0-9]+(?:'[a-z0-9]+)?", sentence.lower())))
