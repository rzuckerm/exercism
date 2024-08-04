#include "isogram.h"

#include <regex>

namespace isogram {
bool is_isogram(const std::string &input) {
    return !std::regex_search(input, std::regex("([a-z]).*\\1", std::regex::icase));
}
}  // namespace isogram
