from itertools import permutations, product

YELLOW, BLUE, RED, IVORY, GREEN = range(5)
NORWEGIAN, SPANIARD, ENGLISHMAN, UKRANIAN, JAPANESE = range(5)
TEA, ORANGE_JUICE, MILK, WATER, COFFEE = range(5)
KOOLS, OLD_GOLD, CHESTERFIELD, LUCKY_STRIKE, PARLIAMENT = range(5)
DOG, HORSE, SNAILS, FOX, ZEBRA = range(5)

COLOR_IDX, NATION_IDX, DRINK_IDX, SMOKE_IDX, PET_IDX = range(5)

NATIONS = ["Norwegian", "Spaniard", "Englishman", "Ukranian", "Japanese", "Unknown"]

# Things that are known by working through the clues
KNOWNS = [
    [YELLOW, BLUE, RED, IVORY, GREEN],
    [NORWEGIAN, -1, ENGLISHMAN, -1, -1],
    [-1, -1, MILK, -1, COFFEE],
    [KOOLS, -1, -1, -1, -1],
    [-1, HORSE, -1, -1, -1],
]

# Combinations of pets and smokes that are known by working through the clues
KNOWN_COMBOS = [
    [0, (PET_IDX, FOX), (SMOKE_IDX, CHESTERFIELD)],
    [1, (SMOKE_IDX, CHESTERFIELD), (PET_IDX, FOX)],
    [2, (SMOKE_IDX, CHESTERFIELD), (PET_IDX, FOX)],
    [3, (PET_IDX, FOX), (SMOKE_IDX, CHESTERFIELD)],
]

# Constraints for solution
CONSTRAINTS = [
    lambda items, c: items[NATION_IDX][c] == SPANIARD and items[PET_IDX][c] == DOG,
    lambda items, c: items[NATION_IDX][c] == JAPANESE and items[SMOKE_IDX][c] == PARLIAMENT,
    lambda items, c: items[NATION_IDX][c] == UKRANIAN and items[DRINK_IDX][c] == TEA,
    lambda items, c: items[PET_IDX][c] == SNAILS and items[SMOKE_IDX][c] == OLD_GOLD,
    lambda items, c: items[DRINK_IDX][c] == ORANGE_JUICE and items[SMOKE_IDX][c] == LUCKY_STRIKE,
]


def drinks_water() -> str:
    return _solve(DRINK_IDX, WATER)


def owns_zebra() -> str:
    return _solve(PET_IDX, ZEBRA)


def _solve(category_index: int, target: int) -> str:
    # Start with knowns and try known combinations
    found = False
    for n, (item_idx1, item1), (item_idx2, item2) in KNOWN_COMBOS:
        solution = [vals.copy() for vals in KNOWNS]
        solution[item_idx1][n], solution[item_idx2][n + 1] = item1, item2

        # Get candidate nations, drinks, smokes, and pets
        existing_items = [set(v for v in row if v >= 0) for row in solution[NATION_IDX:]]
        candidates = [permutations(m for m in range(5) if m not in vals) for vals in existing_items]
        candidate_idxs = [[c for c, v in enumerate(row) if v < 0] for row in solution[NATION_IDX:]]

        # Try out each candidate
        for candidate_items in product(*candidates):
            # Save off previous solution
            prev_solution = [vals.copy() for vals in solution]

            # Put this candidate in the solution
            for r, (cols, vals) in enumerate(zip(candidate_idxs, candidate_items), start=NATION_IDX):
                for c, v in zip(cols, vals):
                    solution[r][c] = v

            # Indicate found and exit loops if solution meets all constraints
            if all(any(constraint(solution, c) for c in range(5)) for constraint in CONSTRAINTS):
                found = True
                break

            # Otherwise, backtrack to previous solution
            solution = prev_solution

        if found:
            break

    # Return nation for requested category and target item (or Unknown if not found)
    return NATIONS[next((n for n, v in enumerate(solution[category_index]) if v == target), -1)]
