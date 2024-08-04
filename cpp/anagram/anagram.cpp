#include "anagram.h"

#include <algorithm>
#include <boost/algorithm/string.hpp>
#include <iterator>

namespace anagram {
static std::string sort_letters(const std::string &word) {
    std::string letters{boost::to_lower_copy(word)};
    std::sort(letters.begin(), letters.end());
    return letters;
}

anagram::anagram(const std::string &word) : word_(boost::to_lower_copy(word)), letters(sort_letters(word)) {}

std::vector<std::string> anagram::matches(const std::vector<std::string> &words) {
    std::vector<std::string> results;
    std::copy_if(words.begin(), words.end(), std::back_inserter(results), [this](const std::string &word) {
        return word_ != boost::to_lower_copy(word) && letters == sort_letters(word);
    });
    return results;
}
}  // namespace anagram
