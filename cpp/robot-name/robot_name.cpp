#include "robot_name.h"
#include <algorithm>
#include <random>
#include <vector>

namespace robot_name
{
static std::vector<std::string> names;

robot::robot()
{
    reset();
}

const std::string robot::name() const
{
    return name_;
}

void robot::reset()
{
    if (!names.size())
    {
        for (int n = 0; n < 676000; n++)
        {
            char buf[6];
            sprintf(buf, "%c%c%03d", (n / 26000) + 'A', ((n / 1000) % 26 + 'A'), n % 1000);
            names.emplace_back(buf);
        }

        std::random_device rd;
        std::mt19937 g(rd());
        std::shuffle(names.begin(), names.end(), g);
    }

    name_ = names.back();
    names.pop_back();
}
} // namespace robot_name
