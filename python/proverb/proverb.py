def proverb(*words, qualifier=None) -> list[str]:
    return [f"For want of a {w1} the {w2} was lost." for w1, w2 in zip(words, words[1:])] + [
        f"And all for the want of a {qualifier + ' ' if qualifier else ''}{w}." for w in words[:1]
    ]
