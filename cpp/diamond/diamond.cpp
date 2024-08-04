#include "diamond.h"

namespace diamond {
std::vector<std::string> rows(char letter) {
    int n{letter - 'A'}, width{2 * n + 1};
    std::vector<std::string> results(width, std::string(width, ' '));
    for (int k = 0; k <= n; k++) {
        results[k][n - k] = results[k][n + k] = 'A' + k;
        results[2 * n - k] = results[k];
    }

    return results;
}
}  // namespace diamond
