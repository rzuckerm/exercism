#include "acronym.h"

#include <algorithm>
#include <regex>

namespace acronym {
std::string acronym(const std::string &input) {
    std::string output = std::regex_replace(input, std::regex("([A-Za-z])[A-Za-z']+"), "$1");
    output = std::regex_replace(output, std::regex("[^A-Za-z]"), "");
    std::transform(output.begin(), output.end(), output.begin(), toupper);
    return output;
}
}  // namespace acronym
