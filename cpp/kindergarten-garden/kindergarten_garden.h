#pragma once
#include <array>
#include <string>

namespace kindergarten_garden {
enum class Plants : char { grass = 'G', clover = 'C', radishes = 'R', violets = 'V' };

std::array<Plants, 4> plants(const std::string &diagram, const std::string &name);
}  // namespace kindergarten_garden
