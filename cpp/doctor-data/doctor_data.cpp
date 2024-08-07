#include "doctor_data.h"

namespace heaven
{
Vessel::Vessel(std::string name, int generation, star_map::System current_system)
    : name(name), generation(generation), current_system(current_system)
{
}

Vessel Vessel::replicate(std::string name)
{
    return Vessel(name, generation + 1, current_system);
}

void Vessel::make_buster()
{
    busters++;
}

bool Vessel::shoot_buster()
{
    if (busters > 0)
    {
        busters--;
        return true;
    }

    return false;
}

std::string get_older_bob(Vessel &vessel1, Vessel &vessel2)
{
    return (vessel1.generation < vessel2.generation) ? vessel1.name : vessel2.name;
}

bool in_the_same_system(Vessel &vessel1, Vessel &vessel2)
{
    return vessel1.current_system == vessel2.current_system;
}
} // namespace heaven
