#include "scrabble_score.h"

#include <numeric>

namespace scrabble_score {
//                  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q   R  S  T  U  V  W  X  Y  Z
static int scores[]{1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};

int score(const std::string &s) {
    return std::accumulate(s.begin(), s.end(), 0, [](int acc, char c) { return acc + scores[tolower(c) - 'a']; });
}
}  // namespace scrabble_score
