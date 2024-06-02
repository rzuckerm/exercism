DominoesT = list[tuple[int, int]]


def can_chain(dominoes: DominoesT) -> DominoesT | None:
    return _find_chain(0, dominoes, _get_chainables(dominoes), set(), []) if dominoes else []


def _get_chainables(dominoes: DominoesT) -> list[list[int]]:
    # Figure out which dominoes can be chained together and in which orientation
    chainables = [
        [2 * j + int(s == s2) for j, (f2, s2) in enumerate(dominoes) if i != j and s in [f2, s2]]
        for i, (f1, s1) in enumerate(dominoes)
        for s in [s1, f1]
    ]

    # Return chainables if all dominoes have at least one match, else empty chainable
    return chainables if all(chainables) else [[]]


def _find_chain(
    key: int, dominoes: DominoesT, chainables: list[list[int]], visited: set[int], chain: DominoesT
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
        if next_key // 2 not in visited and (next_chain := _find_chain(next_key, dominoes, chainables, visited, chain)):
            return next_chain

    # Remove this domino from the chain and indicate no match
    visited.remove(index)
    chain.pop()
    return None
