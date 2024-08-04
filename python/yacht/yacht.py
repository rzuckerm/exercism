# pylint: disable=unnecessary-lambda-assignment
from functools import partial

ONES, TWOS, THREES, FOURS, FIVES, SIXES = [partial(lambda d, n: d.count(n) * n, n=i) for i in range(1, 7)]
FULL_HOUSE = lambda d: sum(d) if len(set(d)) == 2 and d.count(d[0]) in [2, 3] else 0
FOUR_OF_A_KIND = lambda d: 4 * d[1] if len(set(d)) <= 2 and d.count(d[1]) >= 4 else 0
LITTLE_STRAIGHT, BIG_STRAIGHT = [partial(lambda d, n: 30 if d == list(range(n, n + 5)) else 0, n=i) for i in [1, 2]]
CHOICE = sum
YACHT = lambda d: 50 if len(set(d)) == 1 else 0


def score(dice: list[int], category: int) -> int:
    return category(sorted(dice))
