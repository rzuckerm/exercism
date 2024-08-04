#include "pangram.h"
#include <cctype>
#include <numeric>

namespace pangram
{
bool is_pangram(const std::string &input)
{
    return std::accumulate(input.begin(), input.end(), 0, [](int a, char c) {
               return a | (std::isalpha(c) ? 1 << (std::tolower(c) - 'a') : 0);
           }) == (1 << 26) - 1;
}
} // namespace pangram
