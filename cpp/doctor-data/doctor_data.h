#pragma once
#include <string>

namespace star_map
{
enum class System
{
    Sol,
    AlphaCentauri,
    BetaHydri,
    DeltaEridani,
    EpsilonEridani,
    Omicron2Eridani
};
} // namespace star_map

namespace heaven
{
class Vessel
{
  public:
    Vessel(std::string name, int generation, star_map::System current_system = star_map::System::Sol);
    Vessel replicate(std::string name);
    void make_buster();
    bool shoot_buster();

    std::string name;
    int generation;
    star_map::System current_system;
    int busters{0};
};

std::string get_older_bob(Vessel &vessel1, Vessel &vessel2);
bool in_the_same_system(Vessel &vessel1, Vessel &vessel2);
} // namespace heaven
