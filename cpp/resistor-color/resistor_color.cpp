#include "resistor_color.h"

#include <algorithm>

namespace resistor_color {
static std::vector<std::string> table{"black", "brown", "red",    "orange", "yellow",
                                      "green", "blue",  "violet", "grey",   "white"};

int color_code(const std::string &color) { return std::find(table.begin(), table.end(), color) - table.begin(); }

std::vector<std::string> colors() { return table; }
}  // namespace resistor_color
