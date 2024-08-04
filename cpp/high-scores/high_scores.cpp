#include "high_scores.h"

#include <algorithm>

namespace arcade {
std::vector<int> HighScores::list_scores() { return std::vector<int>(scores); }

int HighScores::latest_score() { return scores.back(); }

int HighScores::personal_best() { return *std::max_element(scores.begin(), scores.end()); }

std::vector<int> HighScores::top_three() {
    std::vector<int> top_scores(std::min(std::size_t(3), scores.size()));
    std::partial_sort_copy(scores.begin(), scores.end(), top_scores.begin(), top_scores.end(), std::greater{});
    return top_scores;
}
}  // namespace arcade
