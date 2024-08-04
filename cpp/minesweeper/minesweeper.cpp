#include "minesweeper.h"

namespace minesweeper {
static int directions[][2]{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

std::vector<std::string> annotate(const std::vector<std::string> &input) {
    std::vector<std::string> output(input);
    for (int i = 0, nr = int(output.size()); i < nr; i++) {
        for (int j = 0, nc = int(output[i].size()); j < nc; j++) {
            char count{'0'};
            if (output[i][j] == ' ') {
                for (auto d : directions) {
                    int r{i + d[0]}, c{j + d[1]};
                    count += (r >= 0 && r < nr && c >= 0 && c < nc && output[r][c] == '*');
                    output[i][j] = (count == '0') ? ' ' : count;
                }
            }
        }
    }

    return output;
}
}  // namespace minesweeper
