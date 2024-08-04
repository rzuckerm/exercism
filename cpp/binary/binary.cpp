#include "binary.h"

#include <numeric>

namespace binary {
int convert(const std::string &input) {
    bool valid{true};
    return std::accumulate(input.begin(), input.end(), 0, [&valid](int acc, char c) {
        return (valid = valid && (c == '0' || c == '1')) ? 2 * acc + (c - '0') : 0;
    });
}
}  // namespace binary
