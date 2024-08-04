#include "kindergarten_garden.h"

namespace kindergarten_garden {
std::array<Plants, 4> plants(const std::string &diagram, const std::string &name) {
    auto p = diagram.size() / 2 + 1;
    auto n = 2 * (name[0] - 'A');
    return {Plants{diagram[n]}, Plants{diagram[n + 1]}, Plants{diagram[n + p]}, Plants{diagram[n + p + 1]}};
}
}  // namespace kindergarten_garden
