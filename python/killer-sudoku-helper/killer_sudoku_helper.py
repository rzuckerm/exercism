from itertools import combinations as combos


def combinations(target: int, size: int, exclude: list[int]) -> list[list[int]]:
    possibilities = [i for i in range(1, min(target, 9) + 1) if i not in exclude]
    return [list(numbers) for numbers in combos(possibilities, size) if sum(numbers) == target]
