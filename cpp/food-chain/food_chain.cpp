#include "food_chain.h"
#include <vector>

namespace food_chain
{
static std::string wriggled = "wriggled and jiggled and tickled inside her";
static std::vector<std::vector<std::string>> song{
    // Animal, 2nd line, 2nd line suffix (if any)
    {"fly", "I don't know why she swallowed the fly. Perhaps she'll die.", ""},
    {"spider", "It " + wriggled + ".", " that " + wriggled},
    {"bird", "How absurd to swallow a bird!", ""},
    {"cat", "Imagine that, to swallow a cat!", ""},
    {"dog", "What a hog, to swallow a dog!", ""},
    {"goat", "Just opened her throat and swallowed a goat!", ""},
    {"cow", "I don't know how she swallowed a cow!", ""},
    {"horse", "She's dead, of course!", ""},
};

std::string verse(int n)
{
    std::string lines = "I know an old lady who swallowed a " + song[n - 1][0] + ".\n" + song[n - 1][1] + "\n";
    if (n >= 2 && n <= 7)
    {
        for (int k = n - 1; k >= 1; k--)
        {
            lines += "She swallowed the " + song[k][0] + " to catch the " + song[k - 1][0] + song[k - 1][2] + ".\n";
        }

        lines += song[0][1] + "\n";
    }
    return lines;
}

std::string verses(int start, int end)
{
    std::string lines;
    for (int n = start; n <= end; n++)
    {
        lines += verse(n) + "\n";
    }

    return lines;
}

std::string sing()
{
    return verses(1, 8);
}
} // namespace food_chain
