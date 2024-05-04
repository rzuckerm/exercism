def is_pangram(sentence):
    return sum(ch.islower() for ch in set(sentence.lower())) == 26
