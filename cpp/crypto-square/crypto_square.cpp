#include "crypto_square.h"
#include <algorithm>
#include <cmath>
#include <regex>

namespace crypto_square
{
cipher::cipher(const std::string &text)
{
    cleaned = std::regex_replace(text, std::regex("[^A-Za-z0-9]"), "");
    std::transform(cleaned.begin(), cleaned.end(), cleaned.begin(), tolower);
}

std::string cipher::normalized_cipher_text() const
{
    std::size_t n{cleaned.size()};
    double q{std::sqrt(n)};
    std::size_t r{std::size_t(std::round(q))}, c{std::size_t(std::ceil(q))};
    std::string result;
    for (std::size_t i = 0; i < c; i++)
    {
        for (std::size_t j = 0, idx = i; j < r; j++, idx += c)
        {
            result += (idx < n) ? cleaned[idx] : ' ';
        }

        result += (i < c - 1) ? " " : "";
    }

    return result;
}
} // namespace crypto_square
