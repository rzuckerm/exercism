from itertools import permutations


def solve(puzzle: str) -> dict[str, int] | None:
    # Get words
    words = puzzle.replace("+", " ").replace("==", " ").split()

    # Separate out first letters from other letters
    letters = set("".join(words))
    first_letters = set(word[0] for word in words)
    other_letters, first_letters = sorted(letters - first_letters), sorted(first_letters)
    letters = first_letters + other_letters
    num_first_letters, num_other_letters = len(first_letters), len(other_letters)

    # Improve runtime by precomputing the multiplier for each letter.
    #
    # Each multiplier is the sum of 10**position of the letter counted from
    # right to left for each word. The left side words added, and the right
    # side word is subtracted. Therefore, the solution will be the combination
    # of letter values multiplied by its corresponding multiplier that adds up
    # to zero
    multipliers = {}
    for sign, wds in [(1, words[:-1]), (-1, [words[-1]])]:
        for word in wds:
            multiplier = sign
            for ch in reversed(word):
                multipliers[ch] = multipliers.get(ch, 0) + multiplier
                multiplier *= 10

    # First letters can be 1-9; all other letters can be 0-9. Try all possible
    # values for first letters and other letters. Stop when solution is found
    for first_values in permutations(range(1, 10), num_first_letters):
        candidates = [n for n in range(10) if n not in first_values]
        if num_other_letters < 1:
            solution = dict(zip(letters, first_values))
            if sum(multipliers[ch] * v for ch, v in solution.items()) == 0:
                return solution

        for other_values in permutations(candidates, num_other_letters):
            solution = dict(zip(letters, first_values + other_values))
            if sum(multipliers[ch] * v for ch, v in solution.items()) == 0:
                return solution

    return None
