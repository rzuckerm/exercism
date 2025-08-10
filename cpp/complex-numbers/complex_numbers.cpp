#include "complex_numbers.h"

#include <cmath>

namespace complex_numbers {
Complex::Complex(double real, double imag) : re(real), im(imag) {}

double Complex::real() const { return re; }

double Complex::imag() const { return im; }

Complex Complex::operator+(const Complex &other) const { return Complex(re + other.re, im + other.im); }

Complex Complex::operator+(double other) const { return Complex(re + other, im); }

Complex operator+(double lhs, const Complex &rhs) { return Complex(lhs + rhs.real(), rhs.imag()); }

Complex Complex::operator-(const Complex &other) const { return Complex(re - other.real(), im - other.imag()); }

Complex Complex::operator-(double other) const { return Complex(re - other, im); }

Complex operator-(double lhs, const Complex &rhs) { return Complex(lhs - rhs.real(), -rhs.imag()); }

Complex Complex::operator*(const Complex &other) const {
    return Complex(re * other.real() - im * other.imag(), im * other.real() + re * other.imag());
}

Complex Complex::operator*(double other) const { return Complex(re * other, im * other); }

Complex operator*(double lhs, const Complex &rhs) { return Complex(lhs * rhs.real(), lhs * rhs.imag()); }

Complex Complex::operator/(const Complex &other) const {
    double den = other.re * other.re + other.im * other.im;
    return Complex((re * other.re + im * other.im) / den, (im * other.re - re * other.im) / den);
}

Complex Complex::operator/(double other) const { return Complex(re / other, im / other); }

Complex operator/(double lhs, const Complex &rhs) {
    double den = rhs.real() * rhs.real() + rhs.imag() * rhs.imag();
    return Complex(lhs * rhs.real() / den, -lhs * rhs.imag() / den);
}

double Complex::abs() const { return std::sqrt(re * re + im * im); }

Complex Complex::conj() const { return Complex(re, -im); }

Complex Complex::exp() const {
    double mag = std::exp(re);
    return Complex(mag * std::cos(im), mag * std::sin(im));
}
}  // namespace complex_numbers
