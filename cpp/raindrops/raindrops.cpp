#include "raindrops.h"

namespace raindrops
{
std::string convert(int number)
{
    std::string s;
    s += (number % 3 == 0) ? "Pling" : "";
    s += (number % 5 == 0) ? "Plang" : "";
    s += (number % 7 == 0) ? "Plong" : "";
    return s.empty() ? std::to_string(number) : s;
}
} // namespace raindrops
