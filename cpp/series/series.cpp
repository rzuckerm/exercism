#include "series.h"
#include <stdexcept>

namespace series {
std::vector<std::string> slice(const std::string &digits, int len)
{
    int num_digits{int(digits.size())};
    if (len <= 0 || len > num_digits)
    {
        throw std::domain_error("Invalid series length");
    }

    std::vector<std::string> result;
    for (int i = 0; i <= (num_digits - len); i++)
    {
        result.emplace_back(digits.substr(i, len));
    }

    return result;
}
}  // namespace series
