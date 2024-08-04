#include "largest_series_product.h"

#include <algorithm>
#include <numeric>
#include <stdexcept>
#include <vector>

namespace largest_series_product {
int largest_product(const std::string &input, int span) {
    std::size_t len{input.size()};
    if (span < 1 || span > int(len) || !std::all_of(input.begin(), input.end(), isdigit)) {
        throw std::domain_error("Invalid input");
    }

    return std::transform_reduce(
        input.begin(), input.end() - span + 1, 0, [](int a, int b) { return std::max(a, b); },
        [span](const char &c) {
            return std::accumulate(&c, &c + span, 1, [](int a, char c) { return a * (c - '0'); });
        });
}
}  // namespace largest_series_product