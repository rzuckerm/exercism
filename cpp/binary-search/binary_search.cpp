#include "binary_search.h"
#include <stdexcept>

namespace binary_search
{
std::size_t find(const std::vector<int> &items, int target)
{
    std::size_t low{0}, high{items.size()};
    while (low < high)
    {
        std::size_t mid{(low + high) / 2};
        if (target == items[mid])
        {
            return mid;
        }

        if (items[mid] < target)
        {
            low = mid + 1;
        }
        else
        {
            high = mid;
        }
    }

    throw std::domain_error("Not found");
}
} // namespace binary_search
