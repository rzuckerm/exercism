def find_anagrams(word: str, candidates: list[str]) -> list[str]:
    s_word = sorted(word.lower())
    return [
        candidate
        for candidate in candidates
        if candidate.lower() != word.lower() and sorted(candidate.lower()) == s_word
    ]
