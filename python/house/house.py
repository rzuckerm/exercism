NOUNS_VERBS = [
    ("house", "Jack built."),
    ("malt", "lay in"),
    ("rat", "ate"),
    ("cat", "killed"),
    ("dog", "worried"),
    ("cow with the crumpled horn", "tossed"),
    ("maiden all forlorn", "milked"),
    ("man all tattered and torn", "kissed"),
    ("priest all shaven and shorn", "married"),
    ("rooster that crowed in the morn", "woke"),
    ("farmer sowing his corn", "kept"),
    ("horse and the hound and the horn", "belonged to"),
]


def recite(start_verse: int, end_verse: int) -> list[str]:
    return [
        "This is "
        + " ".join(f"the {noun} that {verb}" for noun, verb in NOUNS_VERBS[n::-1])
        for n in range(start_verse - 1, end_verse)
    ]
