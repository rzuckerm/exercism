def append(list1, list2):
    return concat([list1, list2])


def concat(lists: list[list]):
    return [x for items in lists for x in items]


def filter(function, list):
    return [x for x in list if function(x)]


def length(list):
    return sum(1 for _ in list)


def map(function, list):
    return [function(x) for x in list]


def foldl(function, list, initial):
    acc = initial
    for x in list:
        acc = function(acc, x)

    return acc


def foldr(function, list, initial):
    return foldl(function, reverse(list), initial)


def reverse(list):
    return list[::-1]
