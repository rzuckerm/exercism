#include "say.h"
#include <map>
#include <stdexcept>
#include <vector>

namespace say
{
static std::string first_20[]{"zero",     "one",     "two",     "three",     "four",     "five",    "six",
                              "seven",    "eight",   "nine",    "ten",       "eleven",   "twelve",  "thirteen",
                              "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"};
static std::string multiples_of_ten[]{"",      "",      "twenty",  "thirty", "forty",
                                      "fifty", "sixty", "seventy", "eighty", "ninety"};
static std::map<unsigned long long, std::string> powers{
    {1000000000UL, " billion"}, {1000000UL, " million"}, {1000UL, " thousand"}, {1, ""}};

std::string in_english(unsigned long long n)
{
    if (n >= 1000000000000UL)
    {
        throw std::domain_error("Number must be 0 to 999999999999");
    }

    if (n < 20)
    {
        return first_20[n];
    }

    if (n < 100)
    {
        return multiples_of_ten[n / 10] + ((n % 10) ? "-" + first_20[n % 10] : "");
    }

    if (n < 1000)
    {
        return in_english(n / 100) + " hundred" + ((n % 100) ? " " + in_english(n % 100) : "");
    }

    std::string words;
    for (auto iter = powers.rbegin(); iter != powers.rend(); ++iter)
    {
        if (auto d = (n / iter->first) % 1000)
        {
            words += (words.empty() ? "" : " ") + in_english(d) + iter->second;
        }
    }

    return words;
}
} // namespace say
