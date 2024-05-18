from collections import Counter
from itertools import dropwhile

# Functions to rank a hand based on organized card values.
# Returns rank if hand matches criterion else -1 except for One Pair match which
# returns 1 if One Pair, 0 (High Card) if not
RANKERS = [
    lambda v, _f: 9 if v[0] == v[4] else -1,  # Five of a Kind
    lambda v, f: 8 if f and all(a == b + 1 for a, b in zip(v, v[1:])) else -1,  # Straight Flush
    lambda v, _f: 7 if v[0] == v[3] else -1,  # Four of a Kind
    lambda v, _f: 6 if v[0] == v[2] and v[3] == v[4] else -1,  # Full House
    lambda _v, f: 5 if f else -1,  # Flush
    lambda v, _f: 4 if all(a == b + 1 for a, b in zip(v, v[1:])) else -1,  # Straight
    lambda v, _f: 3 if v[0] == v[2] else -1,  # Three of a kind
    lambda v, _f: 2 if v[0] == v[1] and v[2] == v[3] else -1,  # Two Pair
    lambda v, _f: 1 if v[0] == v[1] else 0,  # One Pair else High Card
]


def best_hands(hands: list[str]) -> list[list[str]]:
    ranked_hands = sorted(((_rank_hand(hand.split()), hand) for hand in hands), reverse=True)
    return [hand for rank, hand in ranked_hands if rank == ranked_hands[0][0]]


def _rank_hand(cards: list[str]) -> list[int]:
    # Convert face value to a number from 2 to 14, where: J=11, Q=12, K=13, A=14,
    # and sort in descending order
    values = sorted((int(c[:-1]) if c[:-1].isdigit() else 11 + "JQKA".index(c[:-1]) for c in cards), reverse=True)

    # Convert Ace low straight
    values = [5, 4, 3, 2, 1] if values == [14, 5, 4, 3, 2] else values

    # Organize values so that values with highest frequency are first and cards with
    # same frequency are in descending order
    org_values = sum(([c] * n for c, n in sorted(Counter(values).items(), key=lambda x: x[1], reverse=True)), [])

    # Find best rank based on organized values and whether this is a Flush
    is_flush = len({card[-1] for card in cards}) == 1
    return [next(dropwhile(lambda r: r < 0, (f(org_values, is_flush) for f in RANKERS)))] + org_values
