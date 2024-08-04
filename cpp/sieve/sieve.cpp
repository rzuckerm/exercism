#include "sieve.h"

namespace sieve {
std::vector<int> primes(int n)
{
    std::vector<bool> sieve_bits(n + 1, true);
    std::vector<int> result;
    for (auto i = 2; i <= n ; i++)
    {
        if (sieve_bits[i])
        {
            result.emplace_back(i);
            for (auto k = i * i; k <= n; k += i)
            {
                sieve_bits[k] = false;
            }
        }
    }

    return result;
}
}  // namespace sieve
