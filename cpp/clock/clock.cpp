#include "clock.h"
#include <iomanip>
#include <sstream>

namespace date_independent
{
clock::clock(int minutes) : minutes((minutes % 1440 + 1440) % 1440)
{
}

clock clock::at(int hour, int minute)
{
    return clock(hour * 60 + minute);
}

clock clock::plus(int minutes_) const
{
    return clock(minutes + minutes_);
}

clock::operator std::string() const
{
    std::ostringstream ss;
    ss << std::setfill('0') << std::setw(2) << (minutes / 60) << ":" << std::setw(2) << (minutes % 60);
    return ss.str();
}

bool clock::operator==(const clock &other) const
{
    return minutes == other.minutes;
}

bool clock::operator!=(const clock &other) const
{
    return minutes != other.minutes;
}
} // namespace date_independent
