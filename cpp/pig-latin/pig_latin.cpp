#include "pig_latin.h"

#include <regex>

namespace pig_latin {
std::string translate(const std::string &input) {
    size_t start{0}, end{0};
    std::string output{};
    while ((start = input.find_first_not_of(' ', end)) != std::string::npos) {
        end = input.find(' ', start);
        std::string word{input.substr(start, end - start)};
        std::smatch m;
        if (!std::regex_match(word, std::regex("^(xr|yt).*")) &&
            (std::regex_match(word, m, std::regex("^(y)(.*)")) ||
             std::regex_match(word, m, std::regex("^([bcdfghjklmnprstvwxz]*qu)(.*)")) ||
             std::regex_match(word, m, std::regex("^([bcdfghjklmnpqrstvwxz]+)(.*)")))) {
            word = m[2].str() + m[1].str();
        }

        output += (output.empty() ? "" : " ") + word + "ay";
    }

    return output;
}
}  // namespace pig_latin
