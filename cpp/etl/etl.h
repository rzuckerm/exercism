#pragma once
#include <map>
#include <vector>

namespace etl {
std::map<char, int> transform(const std::map<int, std::vector<char>> &old);
}  // namespace etl
