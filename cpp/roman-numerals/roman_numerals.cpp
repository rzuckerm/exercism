#include "roman_numerals.h"
#include <map>

namespace roman_numerals
{
static std::map<int, std::string> romans{{1, "I"},   {4, "IV"},   {5, "V"},   {9, "IX"},  {10, "X"},
                                         {40, "XL"}, {50, "L"},   {90, "XC"}, {100, "C"}, {400, "CD"},
                                         {500, "D"}, {900, "CM"}, {1000, "M"}};

std::string convert(int n)
{
    std::string result;
    for (auto iter = romans.rbegin(); iter != romans.rend(); ++iter)
    {
        for (; n >= iter->first; n -= iter->first)
        {
            result += iter->second;
        }
    }

    return result;
}
} // namespace roman_numerals
