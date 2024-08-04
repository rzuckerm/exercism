#pragma once
#include <string>

namespace robot_name
{
class robot
{
  public:
    robot();
    const std::string name() const;
    void reset();

  private:
    std::string name_;
};
} // namespace robot_name
