#include "parallel_letter_frequency.h"

#include <algorithm>
#include <cctype>
#include <execution>

namespace parallel_letter_frequency {
static std::unordered_map<char, int> letter_frequency(const std::string_view &text) {
    std::unordered_map<char, int> result;
    for (auto c : text) {
        if (std::isalpha(c)) {
            result[std::tolower(c)] += 1;
        }
    }

    return result;
}

std::unordered_map<char, int> frequency(const std::vector<std::string_view> &texts) {
    // My benchmark results on Windows 11 PC, WSL 2 Ubuntu 22.04, 12th Gen Intel(R) Core(TM) i7-1255U 1.70 GHz,
    // 16GB RAM:
    //
    // serial
    // ======
    // benchmark name                       samples       iterations    estimated
    //                                      mean          low mean      high mean
    //                                      std dev       low std dev   high std dev
    // -------------------------------------------------------------------------------
    // 10 random texts with 10 KiB each               100             1    120.014 ms
    //                                          1.2012 ms    1.19513 ms    1.21059 ms
    //                                         37.9696 us    27.0525 us    51.4807 us
    //
    // parallel
    // ========
    // benchmark name                       samples       iterations    estimated
    //                                      mean          low mean      high mean
    //                                      std dev       low std dev   high std dev
    // -------------------------------------------------------------------------------
    // 10 random texts with 10 KiB each               100             1    46.6454 ms
    //                                         529.291 us    514.887 us    546.082 us
    //                                          78.907 us    68.5837 us     93.941 us

    std::vector<std::unordered_map<char, int>> indiv_results{texts.size()};
    std::unordered_map<char, int> combined_results;

    // Only run parallel if there are enough texts and at least 1 of them has 1000+ chars.
    // Otherwise, run serial
    if (texts.size() >= 3 &&
        std::any_of(texts.begin(), texts.end(), [](const std::string_view &s) { return s.size() >= 1000; })) {
        std::transform(std::execution::par_unseq, texts.begin(), texts.end(), indiv_results.begin(), letter_frequency);
    } else {
        std::transform(texts.begin(), texts.end(), indiv_results.begin(), letter_frequency);
    }

    for (auto result : indiv_results) {
        for (auto [c, n] : result) {
            combined_results[c] += n;
        }
    }

    return combined_results;
}
}  // namespace parallel_letter_frequency
