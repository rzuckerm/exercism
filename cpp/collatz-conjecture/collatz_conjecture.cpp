#include "collatz_conjecture.h"
#include <stdexcept>

namespace collatz_conjecture
{
int steps(int n)
{
    if (n <= 0)
    {
        throw std::domain_error("Input must be 1 or more");
    }

    int count = 0;
    for (; n != 1; count++)
    {
        n = (n & 1) ? 3 * n + 1 : n / 2;
    }

    return count;
}
} // namespace collatz_conjecture
