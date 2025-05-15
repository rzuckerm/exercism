#include "alphametics.h"

#include <iterator>
#include <set>
#include <string>
#include <vector>

namespace alphametics {
static std::string trim(const std::string &str) {
    auto start = str.find_first_not_of(" ");
    auto end = str.find_last_not_of(" ");
    return str.substr(start, end - start + 1);
}

static std::vector<std::string> split(const std::string &str, const std::string &delimeter) {
    std::size_t prev_pos = 0, pos;
    std::vector<std::string> tokens;
    while ((pos = str.find(delimeter, prev_pos)) != std::string::npos) {
        tokens.push_back(trim(str.substr(prev_pos, pos - prev_pos)));
        prev_pos = pos + delimeter.size();
    }

    tokens.push_back(trim(str.substr(prev_pos)));
    return tokens;
}

class SolutionFinder {
   public:
    SolutionFinder(const std::vector<std::string> &words) : used(10, false) {
        // Separate out first letters from other letters
        std::set<char> seenLetters;
        for (auto word : words) {
            this->firstLetters.insert(word[0]);
            for (auto iter : word) {
                if (seenLetters.insert(iter).second) {
                    this->letters += iter;
                }
            }
        }

        // Improve runtime by precomputing the multiplier for each letter.
        //
        // Each multiplier is the sum of 10**position of the letter counted from
        // right to left for each word. The left side words added, and the right
        // side word is subtracted. Therefore, the solution will be the combination
        // of letter values multiplied by its corresponding multiplier that adds up
        // to zero
        for (std::size_t i = 0; i < words.size(); i++) {
            long long multiplier = ((i + 1) < words.size()) ? 1 : -1;
            for (auto iter = words[i].rbegin(); iter != words[i].rend(); ++iter) {
                this->multipliers[*iter] += multiplier;
                multiplier *= 10;
            }
        }
    }

    bool try_solution(std::map<char, int> &solution, size_t pos = 0, long long sum = 0) {
        if (pos == letters.size()) {
            return sum == 0;
        }

        char c = letters[pos];
        for (int d = 0; d <= 9; d++) {
            if (used[d] || (d == 0 && firstLetters.count(c))) {
                continue;
            }

            used[d] = true;
            solution[c] = d;
            if (try_solution(solution, pos + 1, sum + this->multipliers[c] * d)) {
                return true;
            }

            used[d] = false;
        }

        return false;
    }

   private:
    std::string letters;
    std::set<char> firstLetters;
    std::map<char, long long> multipliers;
    std::vector<bool> used;
};

std::optional<std::map<char, int>> solve(const std::string &str) {
    // Get words
    auto sides = split(str, "==");
    auto words = split(sides[0], "+");
    words.push_back(sides[1]);

    // Find solution
    SolutionFinder finder(words);
    std::map<char, int> solution;
    if (finder.try_solution(solution)) {
        return solution;
    }
    return std::nullopt;
}
}  // namespace alphametics
