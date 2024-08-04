#pragma once
#include <functional>
#include <string>

namespace phone_number
{
class phone_number
{
  public:
    explicit phone_number(const std::string &text);
    std::string number() const;

  private:
    std::string num;
};
} // namespace phone_number
