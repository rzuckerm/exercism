WRIGGLED = "wriggled and jiggled and tickled inside her"
SONG = [
    # Animal, 2nd line, 2nd line suffix (if any)
    ("fly", "I don't know why she swallowed the fly. Perhaps she'll die.", ""),
    ("spider", f"It {WRIGGLED}.", f" that {WRIGGLED}"),
    ("bird", "How absurd to swallow a bird!", ""),
    ("cat", "Imagine that, to swallow a cat!", ""),
    ("dog", "What a hog, to swallow a dog!", ""),
    ("goat", "Just opened her throat and swallowed a goat!", ""),
    ("cow", "I don't know how she swallowed a cow!", ""),
    ("horse", "She's dead, of course!", ""),
]


def recite(start_verse: int, end_verse: int) -> str:
    return "\n\n".join("\n".join(_recite_verse(n)) for n in range(start_verse - 1, end_verse)).splitlines()


def _recite_verse(n: int) -> list[str]:
    lines = [f"I know an old lady who swallowed a {SONG[n][0]}.", SONG[n][1]]
    if 1 <= n <= 6:
        lines += [
            f"She swallowed the {v1[0]} to catch the {v2[0]}{v2[2]}." for v1, v2 in zip(SONG[n::-1], SONG[n - 1 :: -1])
        ] + [SONG[0][1]]

    return lines
