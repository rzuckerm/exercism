from collections import Counter

BOOK_PRICE = 800
DISCOUNT_MULTIPLIER = [0, 100, 2 * 95, 3 * 90, 4 * 80, 5 * 75]


def total(basket: list[int]) -> int:
    counts = sorted(Counter(basket).values(), reverse=True)
    return _find_lowest_price(counts)


def _find_lowest_price(counts: list[int]) -> int:
    lowest_price = BOOK_PRICE * sum(counts)
    n = len([c for c in counts if c > 0]) + 1
    for i, d in enumerate(DISCOUNT_MULTIPLIER[2:n], start=2):
        new_counts = sorted((c - 1 if k < i else c for k, c in enumerate(counts)), reverse=True)
        lowest_price = min(lowest_price, BOOK_PRICE * d // 100 + _find_lowest_price(new_counts))

    return lowest_price
