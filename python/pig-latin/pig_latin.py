import itertools

VOWELS = tuple(iter("aeiou"))
CONSONANTS = tuple(iter("bcdfghjklmnpqrstvwxz"))


def translate(text: str) -> str:
    return " ".join(map(_translate_word, text.split()))


def _translate_word(word: str) -> str:
    if word.startswith(("xr", "yt") + VOWELS):
        return f"{word}ay"

    if word.startswith("y"):
        return f"{word[1:]}yay"

    index = len("".join(itertools.takewhile(lambda x: x in CONSONANTS, word)))
    index += 1 if word[index - 1 : index + 1] == "qu" else 0
    return f"{word[index:]}{word[:index]}ay"
