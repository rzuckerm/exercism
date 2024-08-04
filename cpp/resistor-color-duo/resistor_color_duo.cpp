#include "resistor_color_duo.h"

#include <algorithm>
#include <map>

namespace resistor_color_duo {
static std::map<std::string, int> table{{"black", 0}, {"brown", 1}, {"red", 2},    {"orange", 3}, {"yellow", 4},
                                        {"green", 5}, {"blue", 6},  {"violet", 7}, {"grey", 8},   {"white", 9}};

int value(const std::vector<std::string> &colors) { return table[colors[0]] * 10 + table[colors[1]]; }
}  // namespace resistor_color_duo
