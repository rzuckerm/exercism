#include "hexadecimal.h"

#include <numeric>

namespace hexadecimal {
int convert(const std::string &input) {
    bool valid{true};
    return std::accumulate(input.begin(), input.end(), 0, [&valid](int acc, char c) {
        return (valid = valid && isxdigit(c)) ? 16 * acc + ((c >= '0' && c <= '9') ? (c - '0') : (toupper(c) - 55)) : 0;
    });
}
}  // namespace hexadecimal
