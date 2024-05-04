import operator

OPERATIONS = {
    "plus": operator.add,
    "minus": operator.sub,
    "multiplied": operator.mul,
    "divided": operator.floordiv,
}


def answer(question: str) -> int:
    words = question.removesuffix("?").replace("by", "").split()
    if words[:2] != ["What", "is"]:
        raise ValueError("unknown operation")

    result, words = _get_value(words, 2)
    while words:
        if words[0].isdigit() or words[0].startswith("-"):
            raise ValueError("syntax error")

        func = OPERATIONS.get(words[0])
        if func is None:
            raise ValueError("unknown operation")

        operand, words = _get_value(words, 1)
        result = func(result, operand)

    return result


def _get_value(words: list[str], index: int) -> tuple[int, list[str]]:
    try:
        return int(words[index]), words[index + 1 :]
    except (IndexError, ValueError):
        raise ValueError("syntax error")
