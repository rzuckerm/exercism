#include "rail_fence_cipher.h"

#include <vector>

namespace rail_fence_cipher {
static std::string transform(const std::string &input, int num_rails, bool is_encode) {
    std::vector<std::vector<std::size_t>> rail_indices{std::size_t(num_rails)};
    for (std::size_t k = 0; k < input.size(); k++) {
        rail_indices[abs((k + num_rails - 1) % (2 * num_rails - 2) - num_rails + 1)].emplace_back(k);
    }

    std::string output(input.size(), ' ');
    std::size_t n{0};
    for (auto r : rail_indices) {
        for (auto k : r) {
            output[(is_encode ? n : k)] = input[(is_encode ? k : n)];
            n++;
        }
    }

    return output;
}

std::string encode(const std::string &plaintext, int num_rails) {
    return transform(plaintext, num_rails, true);
}

std::string decode(const std::string &ciphertext, int num_rails) {
    return transform(ciphertext, num_rails, false);
}
}  // namespace rail_fence_cipher
