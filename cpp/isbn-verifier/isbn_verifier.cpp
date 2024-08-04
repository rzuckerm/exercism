#include "isbn_verifier.h"

#include <numeric>
#include <regex>

namespace isbn_verifier {
bool is_valid(const std::string &input) {
    std::string cleaned = std::regex_replace(input, std::regex("-"), "");
    if (!std::regex_match(cleaned, std::regex("\\d{9}[\\dX]"))) {
        return false;
    }

    int n = 10, sum = std::accumulate(cleaned.rbegin(), cleaned.rend(), 0,
                                      [&n](int acc, char c) { return acc + (n--) * (isdigit(c) ? c - '0' : 10); });
    return sum % 11 == 0;
}
}  // namespace isbn_verifier
