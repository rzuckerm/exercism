#include "knapsack.h"

namespace knapsack {
int maximum_value(int max_weight, const std::vector<Item> &items) {
    std::vector<int> m(max_weight + 1, 0);
    for (auto item : items) {
        for (int j = max_weight; j >= item.weight; j--) {
            m[j] = std::max(m[j], m[j - item.weight] + item.value);
        }
    }

    return m[max_weight];
}
}  // namespace knapsack
