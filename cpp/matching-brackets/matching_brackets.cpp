#include "matching_brackets.h"

#include <regex>

namespace matching_brackets {
bool check(const std::string &input) {
    std::string output{std::regex_replace(input, std::regex("[^()\\[\\]{}]"), "")};
    std::size_t len{};
    do {
        len = output.size();
        output = std::regex_replace(output, std::regex("\\(\\)|\\[\\]|\\{\\}"), "");
    } while (len != output.size());

    return output.empty();
}
}  // namespace matching_brackets
