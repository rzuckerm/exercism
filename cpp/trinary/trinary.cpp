#include "trinary.h"
#include <numeric>

namespace trinary
{
int to_decimal(const std::string &s)
{
    bool valid = true;
    return std::accumulate(s.begin(), s.end(), 0, [&valid](int acc, char c) {
        valid = valid && (c >= '0' && c <= '2');
        return valid ? 3 * acc + c - '0' : 0;
    });
}
} // namespace trinary
