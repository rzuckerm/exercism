UNEQUAL, SUBLIST, SUPERLIST, EQUAL = range(4)


def sublist(list_one: list, list_two: list) -> int:
    if list_one == list_two:
        return EQUAL

    a, b = sorted([list_one, list_two], key=len)
    if any(b[n : n + len(a)] == a for n in range(len(b) - len(a) + 1)):
        return SUBLIST if len(a) == len(list_one) else SUPERLIST

    return UNEQUAL
