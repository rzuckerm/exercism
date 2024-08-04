#include "difference_of_squares.h"

namespace difference_of_squares
{
unsigned int square_of_sum(unsigned int n)
{
    return n * n * (n + 1) * (n + 1) / 4;
}

unsigned int sum_of_squares(unsigned int n)
{
    return n * (n + 1) * (2 * n + 1) /6;
}

unsigned int difference(unsigned int n)
{
    return square_of_sum(n) - sum_of_squares(n);
}
} // namespace difference_of_squares
