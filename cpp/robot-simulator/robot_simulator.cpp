#include "robot_simulator.h"

#include <algorithm>
#include <functional>
#include <map>

namespace robot_simulator {
static std::pair<int, int> directions[]{{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
static std::map<char, std::function<void(Robot *)>> funcs{
    {'L', &Robot::turn_left}, {'R', &Robot::turn_right}, {'A', &Robot::advance}};

Robot::Robot(const std::pair<int, int> &position, Bearing bearing) : position(position), bearing(bearing) {}

std::pair<int, int> Robot::get_position() const { return position; }

Bearing Robot::get_bearing() const { return bearing; }

void Robot::turn_right() { bearing = Bearing{(int(bearing) + 1) % 4}; }

void Robot::turn_left() { bearing = Bearing{(int(bearing) + 3) % 4}; }

void Robot::advance() {
    position.first += directions[int(bearing)].first;
    position.second += directions[int(bearing)].second;
}

void Robot::execute_sequence(const std::string &instructions) {
    std::for_each(instructions.begin(), instructions.end(), [this](char c) { return (funcs[c])(this); });
}
}  // namespace robot_simulator
