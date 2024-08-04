#include "beer_song.h"

namespace beer_song
{
static std::string beer(int n, const std::string &suffix, bool cap = false)
{
    std::string no_more = (cap) ? "No more" : "no more";
    return ((n < 1) ? no_more : std::to_string(n)) + " bottle" + ((n != 1) ? "s" : "") + " of beer" + suffix;
}

static std::string take(int n)
{
    return std::string("Take ") + ((n > 1) ? "one" : "it") + " down and pass it around, " +
           beer(n - 1, " on the wall.\n");
}

std::string verse(int n)
{
    return beer(n, " on the wall, ", true) + beer(n, ".\n") +
           (n ? take(n) : "Go to the store and buy some more, " + beer(99, " on the wall.\n"));
}

std::string sing(int start, int end)
{
    std::string verses;
    for (int n = start; n >= end; n--)
    {
        verses += (verses.empty() ? "" : "\n") + verse(n);
    }

    return verses;
}
} // namespace beer_song
