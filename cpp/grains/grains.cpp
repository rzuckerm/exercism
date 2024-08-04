#include "grains.h"

namespace grains
{
unsigned long long square(int number)
{
    return 1ULL << (number - 1);
}

unsigned long long total()
{
    return ~0ULL;
}
} // namespace grains
