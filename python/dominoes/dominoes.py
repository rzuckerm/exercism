DominoesT = list[tuple[int, int]]


def can_chain(dominoes: DominoesT) -> DominoesT | None:
    # If each domino has at least one other match, indicate solution if found,
    # None otherwise
    if chainables := _get_chainables(dominoes):
        return _find_first_chain(0, dominoes, chainables, set(), [])

    # Indicate match if no dominoes or a single domino with same number on both side,
    # None otherwise
    return dominoes if not dominoes or len(dominoes) == 1 and dominoes[0][0] == dominoes[0][1] else None


def _get_chainables(dominoes: DominoesT) -> DominoesT | None:
    # Figure out which dominoes can be chained together and in which orientation
    chainables = [[] for _ in range(2 * len(dominoes))]
    for i, (first1, second1) in enumerate(dominoes):
        for second, index in [(second1, 2 * i), (first1, 2 * i + 1)]:
            for j, (first2, second2) in enumerate(dominoes):
                if i != j and second in [first2, second2]:
                    chainables[index].append(2 * j + int(second == second2))

    # Return chainables if all dominoes have at least one match
    return chainables if all(chainables) else None


def _find_first_chain(
    key: int, dominoes: DominoesT, chainables: DominoesT, visited: set[int], chain: DominoesT
) -> DominoesT | None:
    # Indicate this domino has been tried
    index, first = key // 2, key % 2
    visited.add(index)

    # Append domino in desired orientation to chain
    chain.append((dominoes[index][first], dominoes[index][1 - first]))

    # If all dominoes are in chain, indicate match if first and last dominoes match
    if len(chain) == len(dominoes):
        return chain if chain[-1][1] == chain[0][0] else None

    # Recursively try each domino that can be chained with this one
    for next_key in chainables[key]:
        if next_key // 2 not in visited and (
            next_chain := _find_first_chain(next_key, dominoes, chainables, visited, chain)
        ):
            return next_chain

    # Remove this domino from the chain and indicate no match
    visited.remove(index)
    chain.pop()
    return None
