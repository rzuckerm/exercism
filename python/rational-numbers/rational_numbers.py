from math import gcd


class Rational:
    def __init__(self, numer: int, denom: int):
        g = gcd(numer, denom)
        self.numer = (numer if denom >= 0 else -numer) // g
        self.denom = abs(denom) // g

    def __eq__(self, other):
        return self.numer == other.numer and self.denom == other.denom

    def __repr__(self):
        return f"{self.numer}/{self.denom}"

    def __add__(self, other):
        return Rational(self.numer * other.denom + self.denom * other.numer, self.denom * other.denom)

    def __sub__(self, other):
        return Rational(self.numer * other.denom - self.denom * other.numer, self.denom * other.denom)

    def __mul__(self, other):
        return Rational(self.numer * other.numer, self.denom * other.denom)

    def __truediv__(self, other):
        return Rational(self.numer * other.denom, self.denom * other.numer)

    def __abs__(self):
        return Rational(abs(self.numer), self.denom)

    def __pow__(self, power: int):
        x, y = (self.numer, self.denom) if power >= 0 else (self.denom, self.numer)
        return Rational(x ** abs(power), y ** abs(power))

    def __rpow__(self, base: int) -> float:
        return base ** (self.numer / self.denom)
