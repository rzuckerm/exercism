#pragma once
#include <string>

namespace date_independent
{
class clock
{
  public:
    clock(int minutes);
    static clock at(int hour, int minute);
    clock plus(int minutes_) const;
    operator std::string() const;
    bool operator==(const clock &other) const;
    bool operator!=(const clock &other) const;

  private:
    int minutes;
};
} // namespace date_independent
