#include "all_your_base.h"

#include <algorithm>
#include <numeric>
#include <stdexcept>

namespace all_your_base {
std::vector<unsigned int> convert(unsigned int from, const std::vector<unsigned int> &digits, unsigned int to) {
    if (from < 2 || to < 2 || std::any_of(digits.begin(), digits.end(), [from](unsigned int d) { return d >= from; })) {
        throw std::invalid_argument("Invalid input");
    }

    unsigned int value = std::accumulate(digits.begin(), digits.end(), 0,
                                         [from](unsigned int acc, unsigned int d) { return from * acc + d; });
    std::vector<unsigned int> result;
    for (; value; value /= to) {
        result.emplace_back(value % to);
    }

    return {result.rbegin(), result.rend()};
}
}  // namespace all_your_base
