#pragma once
#include <string>

namespace run_length_encoding {
std::string encode(const std::string &input);
std::string decode(const std::string &input);
}  // namespace run_length_encoding
