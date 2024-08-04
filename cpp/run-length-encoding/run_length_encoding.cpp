#include "run_length_encoding.h"

#include <regex>

namespace run_length_encoding {
std::string encode(const std::string &input) {
    std::regex pattern{"(.)\\1*"};
    std::string output;
    const std::sregex_iterator end;
    for (std::sregex_iterator iter(input.begin(), input.end(), pattern); iter != end; ++iter) {
        std::size_t n = (*iter)[0].length();
        output += (n < 2) ? (*iter)[1].str() : std::to_string(n) + (*iter)[1].str();
    }

    return output;
}

std::string decode(const std::string &input) {
    std::regex pattern{"(\\d*)(\\D)"};
    std::string output;
    const std::sregex_iterator end;
    for (std::sregex_iterator iter(input.begin(), input.end(), pattern); iter != end; ++iter) {
        std::string n = (*iter)[1].str();
        output += (n.empty()) ? (*iter)[2].str() : std::string(std::stoi(n), (*iter)[2].str()[0]);
    }

    return output;
}
}  // namespace run_length_encoding
