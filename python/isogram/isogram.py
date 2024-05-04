def is_isogram(string):
    letters = "".join(filter(str.islower, string.lower()))
    return len(set(letters)) == len(letters)
