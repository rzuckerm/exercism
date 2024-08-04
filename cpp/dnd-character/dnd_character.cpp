#include "dnd_character.h"

#include <random>

namespace dnd_character {
static std::random_device rd;
static std::mt19937 g(rd());
static std::uniform_int_distribution<> distrib(1, 6);

int modifier(int constitution) { return constitution / 2 - 5; }

int ability() {
    int sum{0}, min{7};
    for (auto i = 0; i < 4; i++) {
        auto d = distrib(g);
        sum += d;
        min = (d < min) ? d : min;
    }

    return sum - min;
}

Character::Character() {
    strength = ability();
    dexterity = ability();
    constitution = ability();
    intelligence = ability();
    wisdom = ability();
    charisma = ability();
    hitpoints = modifier(constitution) + 10;
}
}  // namespace dnd_character
