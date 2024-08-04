#include "nth_prime.h"
#include <stdexcept>

namespace nth_prime
{
bool _is_prime(unsigned int p)
{
    bool found{true};
    for (unsigned int k = 2; k * k <= p && (found = (p % k) != 0); k++)
    {
    }

    return found;
}

unsigned int nth(unsigned int n)
{
    if (n < 1)
    {
        throw std::domain_error("n must be at least 1");
    }

    unsigned int p{1};
    for (unsigned i = 0; i < n; i++)
    {
        for (p++; !_is_prime(p); p++)
        {
        }
    }

    return p;
}
} // namespace nth_prime
