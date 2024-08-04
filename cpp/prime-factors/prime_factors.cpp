#include "prime_factors.h"

namespace prime_factors
{
std::vector<int> of(int n)
{
    std::vector<int> factors;
    for (int i = 2; i <= n; i++)
    {
        while (n > 0 && n % i == 0)
        {
            factors.emplace_back(i);
            n /= i;
        }
    }

    return factors;
}
} // namespace prime_factors
