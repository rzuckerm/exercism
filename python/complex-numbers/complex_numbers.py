import math


class ComplexNumber:
    def __init__(self, real, imaginary):
        self.real = float(real)
        self.imaginary = float(imaginary)

    def __eq__(self, other):
        other = _to_complex(other)
        return self.real == other.real and self.imaginary == other.imaginary

    def __add__(self, other):
        other = _to_complex(other)
        return ComplexNumber(self.real + other.real, self.imaginary + other.imaginary)

    __radd__ = __add__

    def __mul__(self, other):
        other = _to_complex(other)
        return ComplexNumber(
            self.real * other.real - self.imaginary * other.imaginary,
            self.real * other.imaginary + self.imaginary * other.real,
        )

    __rmul__ = __mul__

    def __sub__(self, other):
        other = _to_complex(other)
        return ComplexNumber(self.real - other.real, self.imaginary - other.imaginary)

    def __rsub__(self, other):
        return _to_complex(other) - self

    def __truediv__(self, other):
        other = _to_complex(other)
        den = other.real * other.real + other.imaginary * other.imaginary
        return ComplexNumber(other.real / den, -other.imaginary / den) * self

    def __rtruediv__(self, other):
        return _to_complex(other) / self

    def __abs__(self):
        return math.sqrt(self.real * self.real + self.imaginary * self.imaginary)

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)

    def exp(self):
        return math.exp(self.real) * ComplexNumber(math.cos(self.imaginary), math.sin(self.imaginary))


def _to_complex(value):
    return value if isinstance(value, ComplexNumber) else ComplexNumber(value, 0)
