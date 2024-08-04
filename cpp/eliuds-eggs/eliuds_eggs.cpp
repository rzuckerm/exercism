#include "eliuds_eggs.h"

namespace chicken_coop {
int positions_to_quantity(unsigned int code) {
    int count{0};
    for (int k = 0; code && k <= 31; count += (code >> k) & 1, k++) {
    }
    return count;
}
}  // namespace chicken_coop
