#pragma once
#include <string>
#include <utility>

namespace robot_simulator {
enum class Bearing { NORTH, EAST, SOUTH, WEST };

class Robot {
   public:
    Robot(const std::pair<int, int> &position = {0, 0}, Bearing bearing = Bearing::NORTH);
    std::pair<int, int> get_position() const;
    Bearing get_bearing() const;
    void turn_right();
    void turn_left();
    void advance();
    void execute_sequence(const std::string &instructions);

   private:
    std::pair<int, int> position;
    Bearing bearing;
};
}  // namespace robot_simulator
