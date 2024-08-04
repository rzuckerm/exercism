#include "darts.h"

#include <cmath>

namespace darts {
static int scores[]{10, 10, 5, 5, 5, 5, 1, 1, 1, 1, 1};

int score(double x, double y) {
    int rsq{int(std::ceil(std::sqrt(x * x + y * y)))};
    return (rsq <= 10) ? scores[rsq] : 0;
}
}  // namespace darts
