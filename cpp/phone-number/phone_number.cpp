#include "phone_number.h"
#include <algorithm>
#include <cctype>
#include <iterator>
#include <stdexcept>

namespace phone_number
{
phone_number::phone_number(const std::string &text)
{
    std::copy_if(text.begin(), text.end(), std::back_inserter(num), [](char c) { return std::isdigit(c); });
    num = (num.size() == 11 && num[0] == '1') ? num.substr(1) : num;
    if (num.size() != 10 || num[0] < '2' || num[3] < '2')
    {
        throw std::domain_error("Invalid phone number");
    }
}

std::string phone_number::number() const
{
    return num;
}
} // namespace phone_number
