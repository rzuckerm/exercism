#include "perfect_numbers.h"

#include <stdexcept>

namespace perfect_numbers {
static classification classifications[]{classification::abundant, classification::deficient, classification::perfect};

classification classify(int n) {
    if (n < 1) {
        throw std::domain_error("Number must be 1 or more");
    }

    int sum{n > 1};
    for (auto i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            sum += i + ((n != i * i) ? n / i : 0);
        }
    }
    return classifications[2 * (sum == n) + (sum < n)];
}
}  // namespace perfect_numbers
