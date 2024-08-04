#include "etl.h"

#include <cctype>

namespace etl {
std::map<char, int> transform(const std::map<int, std::vector<char>> &old) {
    std::map<char, int> result;
    for (auto old_iter : old) {
        for (auto letter : old_iter.second) {
            result[std::tolower(letter)] = old_iter.first;
        }
    }

    return result;
}
}  // namespace etl
