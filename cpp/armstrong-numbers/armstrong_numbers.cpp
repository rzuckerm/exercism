#include "armstrong_numbers.h"

#include <cmath>
#include <numeric>

namespace armstrong_numbers {
bool is_armstrong_number(int number) {
    std::string s{std::to_string(number)};
    return std::accumulate(s.begin(), s.end(), 0,
                           [n{s.size()}](int acc, char c) { return acc + std::pow(c - '0', n); }) == number;
}
}  // namespace armstrong_numbers
