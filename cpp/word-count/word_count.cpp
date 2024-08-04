#include "word_count.h"
#include <boost/algorithm/string.hpp>
#include <regex>

namespace word_count
{
std::map<std::string, int> words(const std::string &input)
{
    std::map<std::string, int> counts;
    auto r = std::regex("[A-Za-z0-9]+(?:'[A-Za-z0-9]+)?");
    auto end = std::sregex_iterator();
    for (std::sregex_iterator iter(input.begin(), input.end(), r); iter != end; ++iter)
    {
        counts[boost::to_lower_copy(iter->str())]++;
    }

    return counts;
}
} // namespace word_count
