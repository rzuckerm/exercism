#include "zebra_puzzle.h"

#include <algorithm>
#include <map>
#include <set>
#include <vector>

namespace zebra_puzzle {
static std::map<std::string, std::vector<std::string>> items{
    {"Nation", {"Norwegian", "Spaniard", "Englishman", "Ukranian", "Japanese"}},
    {"Drink", {"Tea", "Orange Juice", "Milk", "Water", "Coffee"}},
    {"Hobby", {"Painting", "Dancing", "Reading", "Football", "Chess"}},
    {"Pet", {"Dog", "Horse", "Snails", "Fox", "Zebra"}}};

// Things that are known by working through the clues
static std::map<std::string, std::vector<std::string>> knowns{
    // Since all colors are known, there's no need to include them
    // {"Color", {"Yellow", "Blue", "Red", "Ivory", "Green"}},
    {"Nation", {"Norwegian", "", "Englishman", "", ""}},
    {"Drink", {"", "", "Milk", "", "Coffee"}},
    {"Hobby", {"Painting", "", "", "", ""}},
    {"Pet", {"", "Horse", "", "", ""}}};

// Combinations of pets and hobbies that are known by working through the clues
static std::string known_combos[][2][2]{{{"Pet", "Fox"}, {"Hobby", "Reading"}},
                                        {{"Hobby", "Reading"}, {"Pet", "Fox"}},
                                        {{"Hobby", "Reading"}, {"Pet", "Fox"}},
                                        {{"Pet", "Fox"}, {"Hobby", "Reading"}}};

static void set_items(std::vector<std::string> &solution, const std::vector<std::string> &items,
                      const std::vector<int> &idxs) {
    for (size_t i = 0; i < idxs.size(); i++) {
        solution[idxs[i]] = items[i];
    }
}

static bool check_solution(const std::vector<std::string> &items1, const std::string &item1,
                           const std::vector<std::string> &items2, const std::string &item2) {
    return std::find(items1.begin(), items1.end(), item1) - items1.begin() ==
           std::find(items2.begin(), items2.end(), item2) - items2.begin();
}

static std::string find_item(const std::vector<std::string> &solution, const std::string &target) {
    return items["Nation"][std::find(solution.begin(), solution.end(), target) - solution.begin()];
}

Solution solve() {
    // Start with knowns and try known combinations
    for (int n = 0; n < 4; n++) {
        auto solution(knowns);
        std::string category1{known_combos[n][0][0]}, item1{known_combos[n][0][1]};
        std::string category2{known_combos[n][1][0]}, item2{known_combos[n][1][1]};
        solution[category1][n] = item1;
        solution[category2][n + 1] = item2;

        // Get candidate nations, drinks, hobbies, and pets
        std::map<std::string, std::vector<std::string>> candidates;
        std::map<std::string, std::vector<int>> unknown_idxs;
        for (auto solution_iter : solution) {
            auto solution_items = solution_iter.second;
            auto candidate_items = items[solution_iter.first];
            std::set<std::string> candidate_set(candidate_items.begin(), candidate_items.end());
            for (int i = 0; i < 5; i++) {
                if (solution_items[i].empty()) {
                    unknown_idxs[solution_iter.first].emplace_back(i);
                } else {
                    candidate_set.erase(solution_items[i]);
                }
            }

            candidates[solution_iter.first] = std::vector(candidate_set.begin(), candidate_set.end());
        }

        // Try out candidate nations
        do {
            // Put this permutation of nations into the solution
            set_items(solution["Nation"], candidates["Nation"], unknown_idxs["Nation"]);

            // Try out candidate pets
            do {
                // Put this permutation of pets into the solution
                set_items(solution["Pet"], candidates["Pet"], unknown_idxs["Pet"]);

                // If Spaniard doesn't have a dog, try another pet permutation
                if (!check_solution(solution["Nation"], "Spaniard", solution["Pet"], "Dog")) {
                    continue;
                }

                // Try out candidate hobbies
                do {
                    // Put this permutation of hobbies into the solution
                    set_items(solution["Hobby"], candidates["Hobby"], unknown_idxs["Hobby"]);

                    // If the Japanese doesn't play chess or the owner of snails doesn't dance,
                    // try another hobby permutation
                    if (!check_solution(solution["Nation"], "Japanese", solution["Hobby"], "Chess") ||
                        !check_solution(solution["Pet"], "Snails", solution["Hobby"], "Dancing")) {
                        continue;
                    }

                    // Try out candidate drinks
                    do {
                        // Put this permutation of drinks into the solution
                        set_items(solution["Drink"], candidates["Drink"], unknown_idxs["Drink"]);

                        // If the Ukranian drinks tea and the drinker of orange juice play football,
                        // return the solution
                        if (check_solution(solution["Nation"], "Ukranian", solution["Drink"], "Tea") &&
                            check_solution(solution["Drink"], "Orange Juice", solution["Hobby"], "Football")) {
                            return {find_item(solution["Drink"], "Water"), find_item(solution["Pet"], "Zebra")};
                        }
                    } while (std::next_permutation(candidates["Drink"].begin(), candidates["Drink"].end()));
                } while (std::next_permutation(candidates["Hobby"].begin(), candidates["Hobby"].end()));
            } while (std::next_permutation(candidates["Pet"].begin(), candidates["Pet"].end()));
        } while (std::next_permutation(candidates["Nation"].begin(), candidates["Nation"].end()));
    }

    return {};
}
}  // namespace zebra_puzzle