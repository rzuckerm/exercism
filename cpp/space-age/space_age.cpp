#include "space_age.h"

namespace space_age
{
space_age::space_age(unsigned long seconds) : secs(seconds)
{
}

unsigned long space_age::seconds() const
{
    return secs;
}

double space_age::on_mercury() const
{
    return on_planet(0.2408467);
}

double space_age::on_venus() const
{
    return on_planet(0.61519726);
}

double space_age::on_earth() const
{
    return on_planet(1.0);
}

double space_age::on_mars() const
{
    return on_planet(1.8808158);
}

double space_age::on_jupiter() const
{
    return on_planet(11.862615);
}

double space_age::on_saturn() const
{
    return on_planet(29.447498);
}

double space_age::on_uranus() const
{
    return on_planet(84.016846);
}

double space_age::on_neptune() const
{
    return on_planet(164.79132);
}

double space_age::on_planet(double scale) const
{
    return double(secs) / (scale * 31557600.0);
}
} // namespace space_age
