#pragma once

namespace complex_numbers
{
class Complex
{
    Complex friend operator+(double lhs, const Complex &rhs);
    Complex friend operator-(double lhs, const Complex &rhs);
    Complex friend operator*(double lhs, const Complex &rhs);
    Complex friend operator/(double lhs, const Complex &rhs);

  public:
    Complex(double real, double imag);
    double real() const;
    double imag() const;
    Complex operator+(const Complex &other) const;
    Complex operator+(double other) const;
    Complex operator-(const Complex &other) const;
    Complex operator-(double other) const;
    Complex operator*(const Complex &other) const;
    Complex operator*(double other) const;
    Complex operator/(const Complex &other) const;
    Complex operator/(double other) const;
    double abs() const;
    Complex conj() const;
    Complex exp() const;

  private:
    double re;
    double im;
};
} // namespace complex_numbers
