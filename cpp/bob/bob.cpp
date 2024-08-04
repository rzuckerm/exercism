#include "bob.h"
#include <regex>

namespace bob
{
static std::string replies[]{"Whatever.", "Whoa, chill out!", "Sure.", "Calm down, I know what I'm doing!",
                             "Fine. Be that way!"};

std::string hey(const std::string &text)
{
    std::string cleaned = std::regex_replace(text, std::regex("[^A-Za-z0-9?]"), "");

    // bit 2        | bit 1    | bit 0    ||
    // empty string | question | all caps || result
    // 0            | 0        | 0        || Whatever.
    // 0            | 0        | 1        || Whoa, chill out!
    // 0            | 1        | 0        || Sure.
    // 0            | 1        | 1        || Calm down, I know what I'm doing!
    // 1            | 0        | 0        || Fine. Be that way!
    bool is_silence = cleaned.empty();
    bool is_shout = std::regex_search(cleaned, std::regex("[A-Za-z]")) && !std::regex_search(cleaned, std::regex("[a-z]"));
    return replies[(is_silence << 2) | ((!is_silence && cleaned.back() == '?') << 1) | is_shout];
}
} // namespace bob
