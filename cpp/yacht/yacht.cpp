#include "yacht.h"

#include <algorithm>
#include <map>
#include <numeric>
#include <set>

namespace yacht {
static std::map<std::string, int> nums{{"ones", 1},  {"twos", 2},  {"threes", 3},
                                       {"fours", 4}, {"fives", 5}, {"sixes", 6}};
static std::map<std::string, int> straights{{"little straight", 1}, {"big straight", 2}};

int score(const std::vector<int> &dice, const std::string &category) {
    std::vector<int> sdice(dice);
    std::sort(sdice.begin(), sdice.end());
    auto unique{std::set<int>(dice.begin(), dice.end()).size()};
    int total{std::accumulate(dice.begin(), dice.end(), 0)};

    auto iter = nums.find(category);
    auto siter = straights.find(category);
    if (iter != nums.end()) {
        return std::accumulate(sdice.begin(), sdice.end(), 0,
                               [n = iter->second](int acc, int d) { return acc + ((d == n) ? d : 0); });
    } else if (category == "full house") {
        return (unique == 2 && sdice[0] == sdice[1] && sdice[3] == sdice[4]) ? total : 0;
    } else if (category == "four of a kind") {
        return (unique <= 2 && sdice[1] == sdice[3]) ? 4 * sdice[1] : 0;
    } else if (siter != straights.end()) {
        return (unique == 5 && sdice[0] == siter->second && sdice[4] == siter->second + 4) ? 30 : 0;
    } else if (category == "yacht") {
        return (unique == 1) ? 50 : 0;
    }

    return (category == "choice") ? total : 0;
}
}  // namespace yacht
