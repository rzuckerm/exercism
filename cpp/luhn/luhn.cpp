#include "luhn.h"

#include <numeric>
#include <regex>

namespace luhn {
bool valid(const std::string &input) {
    std::string cleaned = std::regex_replace(input, std::regex("\\s"), "");
    if (cleaned.size() < 2 || std::regex_match(cleaned, std::regex("\\D"))) {
        return false;
    }

    int m = 2, sum = std::accumulate(cleaned.rbegin(), cleaned.rend(), 0, [&m](int acc, char c) {
                   int d = (m = 3 - m) * (c - '0');
                   return acc + d % 10 + d / 10;
               });
    return sum % 10 == 0;
}
}  // namespace luhn
