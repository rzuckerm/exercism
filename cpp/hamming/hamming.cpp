#include "hamming.h"
#include <stdexcept>

namespace hamming
{
unsigned int compute(const std::string &a, const std::string &b)
{
    if (a.size() != b.size())
    {
        throw std::domain_error("Lengths must be equal");
    }

    unsigned int distance{};
    for (size_t i = 0; i < a.size(); i++)
    {
        distance += a[i] != b[i];
    }
    return distance;
}
} // namespace hamming
