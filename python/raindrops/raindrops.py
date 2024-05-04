FACTORS_SOUNDS = [(3, "Pling"), (5, "Plang"), (7, "Plong")]


def convert(number):
    sounds = "".join(sound for factor, sound in FACTORS_SOUNDS if number % factor == 0)
    return sounds or str(number)
