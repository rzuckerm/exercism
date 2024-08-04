from itertools import combinations_with_replacement


def find_fewest_coins(coins: list[int], target: int) -> list[int]:
    if target < 0:
        raise ValueError("target can't be negative")

    # Try all combinations of coins up to maximum number of coins to find
    # the target sum
    for n in range(target // min(coins) + 1):
        for c in combinations_with_replacement(coins, n):
            if sum(c) == target:
                return list(c)

    raise ValueError("can't make target with given coins")
