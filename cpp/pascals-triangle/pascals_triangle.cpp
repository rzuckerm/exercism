#include "pascals_triangle.h"

namespace pascals_triangle {
std::vector<std::vector<int>> generate_rows(int n) {
    std::vector<std::vector<int>> rows;
    for (auto i = 0; i < n; i++) {
        rows.emplace_back(std::vector<int>(i + 1, 1));
        for (auto j = 1; j < i; j++) {
            rows[i][j] = rows[i - 1][j - 1] + rows[i - 1][j];
        }
    }
    return rows;
}
}  // namespace pascals_triangle
