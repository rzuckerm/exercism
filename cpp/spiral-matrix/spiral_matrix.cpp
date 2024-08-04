#include "spiral_matrix.h"

#include <utility>

namespace spiral_matrix {
std::vector<std::vector<uint32_t>> spiral_matrix(int n) {
    std::vector<std::vector<uint32_t>> result(n, std::vector<uint32_t>(n, 0));
    std::pair<int, int> p{0, 0}, d{0, 1};
    for (int i = 1; i <= n * n; i++) {
        result[p.first][p.second] = i;
        p = std::make_pair(p.first + d.first, p.second + d.second);
        if (p.first < 0 || p.first >= n || p.second < 0 || p.second >= n || result[p.first][p.second] != 0) {
            p = std::make_pair(p.first - d.first + d.second, p.second - d.second - d.first);
            d = std::make_pair(d.second, -d.first);
        }
    }

    return result;
}
}  // namespace spiral_matrix
