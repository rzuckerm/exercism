#include "rotational_cipher.h"

#include <numeric>

namespace rotational_cipher {
std::string rotate(const std::string &input, int n) {
    return std::accumulate(input.begin(), input.end(), std::string(), [n](std::string &acc, char c) {
        return acc + std::string(1, isalpha(c) ? ((c & 0x1f) + n - 1) % 26 + 'A' + (c & 0x20) : c);
    });
}
}  // namespace rotational_cipher
