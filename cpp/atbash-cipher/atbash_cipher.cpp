#include "atbash_cipher.h"
#include <cctype>
#include <numeric>

namespace atbash_cipher
{
std::string encode(const std::string &text)
{
    std::string d = decode(text);
    return std::accumulate(d.begin(), d.end(), std::string(), [](const std::string &a, char c) {
        return a + ((a.size() % 6 == 5) ? " " : "") + std::string(1, c);
    });
}

std::string decode(const std::string &text)
{
    return std::accumulate(text.begin(), text.end(), std::string(), [](const std::string &a, char c) {
        return a + (std::isalnum(c) ? std::string(1, std::isalpha(c) ? 219 - std::tolower(c) : c) : "");
    });
}
} // namespace atbash_cipher
