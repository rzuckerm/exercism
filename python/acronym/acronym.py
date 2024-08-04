def abbreviate(words: str) -> str:
    return "".join(word[0] for word in words.replace("-", " ").replace("_", " ").split()).upper()
