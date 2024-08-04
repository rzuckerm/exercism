#include "sum_of_multiples.h"
#include <numeric>
#include <set>

namespace sum_of_multiples
{
int to(const std::vector<int> &factors, int n)
{
    std::set<int> multiples;
    for (auto factor : factors)
    {
        for (auto m = factor; m < n; m += factor)
        {
            multiples.insert(m);
        }
    }

    return std::accumulate(multiples.begin(), multiples.end(), 0);
}
} // namespace sum_of_multiples
