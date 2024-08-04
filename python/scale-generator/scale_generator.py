CHROMATIC = "A A# B C C# D D# E F F# G G# A Bb B C Db D Eb E F Gb G Ab".split()
SHARPS = {"C", "G", "D", "A", "E", "B", "F#", "a", "e", "b", "f#", "c#", "g#", "d#"}
INTERVALS = {"m": 1, "M": 2, "A": 3}


class Scale:
    def __init__(self, tonic: str):
        self.scale = CHROMATIC[:12] if tonic in SHARPS else CHROMATIC[12:]
        self.index = self.scale.index(tonic.capitalize())

    def chromatic(self) -> list[str]:
        return self.interval("m" * 11)

    def interval(self, intervals: str) -> list[str]:
        k = self.index
        indices = [k] + [k := (k + INTERVALS[ch]) % 12 for ch in intervals]
        return [self.scale[n] for n in indices]
