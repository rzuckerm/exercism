#include "complex_numbers.h"
#include <cmath>

namespace complex_numbers
{
Complex::Complex(double real, double imag) : re(real), im(imag)
{
}

double Complex::real() const
{
    return re;
}

double Complex::imag() const
{
    return im;
}

Complex Complex::operator+(const Complex &other) const
{
    return Complex(re + other.re, im + other.im);
}

Complex Complex::operator+(double other) const
{
    return Complex(re + other, im);
}

Complex operator+(double lhs, const Complex &rhs)
{
    return Complex(lhs + rhs.re, rhs.im);
}

Complex Complex::operator-(const Complex &other) const
{
    return Complex(re - other.re, im - other.im);
}

Complex Complex::operator-(double other) const
{
    return Complex(re - other, im);
}

Complex operator-(double lhs, const Complex &rhs)
{
    return Complex(lhs - rhs.re, -rhs.im);
}

Complex Complex::operator*(const Complex &other) const
{
    return Complex(re * other.re - im * other.im, im * other.re + re * other.im);
}

Complex Complex::operator*(double other) const
{
    return Complex(re * other, im * other);
}

Complex operator*(double lhs, const Complex &rhs)
{
    return Complex(lhs * rhs.re, lhs * rhs.im);
}

Complex Complex::operator/(const Complex &other) const
{
    double den = other.re * other.re + other.im * other.im;
    return Complex((re * other.re + im * other.im) / den, (im * other.re - re * other.im) / den);
}

Complex Complex::operator/(double other) const
{
    return Complex(re / other, im / other);
}

Complex operator/(double lhs, const Complex &rhs)
{
    double den = rhs.re * rhs.re + rhs.im * rhs.im;
    return Complex(lhs * rhs.re / den, -lhs * rhs.im / den);
}

double Complex::abs() const
{
    return std::sqrt(re * re + im * im);
}

Complex Complex::conj() const
{
    return Complex(re, -im);
}

Complex Complex::exp() const
{
    double mag = std::exp(re);
    return Complex(mag * std::cos(im), mag * std::sin(im));
}
} // namespace complex_numbers
