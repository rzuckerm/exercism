#include "affine_cipher.h"

#include <cctype>
#include <functional>
#include <numeric>
#include <stdexcept>

static const int INVERSES[] = {1, 9, 21, 15, 3, 19, 0, 7, 23, 11, 5, 17, 25};

namespace affine_cipher {
static std::string _transform(const std::string &str, int a, std::function<int(char)> func) {
    if (a % 2 == 0 || a % 13 == 0) {
        throw std::invalid_argument("a and m must be coprime.");
    }
    return std::accumulate(str.begin(), str.end(), std::string(), [&func](const std::string &acc, char c) {
        if (!isdigit(c) && !isalpha(c)) {
            return acc;
        }
        return acc + (char)((isdigit(c)) ? c : (26 + func(tolower(c) - 'a') % 26) % 26 + 'a');
    });
}

std::string encode(const std::string &str, int a, int b) {
    std::string temp = _transform(str, a, [a, b](char x) { return a * x + b; });
    std::string result = temp.substr(0, 5);
    for (size_t i = 5; i < temp.size(); i += 5) {
        result += " " + temp.substr(i, 5);
    }
    return result;
}

std::string decode(const std::string &str, int a, int b) {
    return _transform(str, a, [a, b](char x) { return INVERSES[a >> 1] * (x - b); });
}
}  // namespace affine_cipher
