#include <algorithm>
#include "reverse_string.h"

namespace reverse_string
{
std::string reverse_string(const std::string &input)
{
    return std::string(input.rbegin(), input.rend());
}
} // namespace reverse_string
