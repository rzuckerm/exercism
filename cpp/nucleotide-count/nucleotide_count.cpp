#include "nucleotide_count.h"
#include <algorithm>
#include <stdexcept>

namespace nucleotide_count
{
std::map<char, int> count(const std::string &dna)
{
    std::map<char, int> counts{{'A', 0}, {'C', 0}, {'G', 0}, {'T', 0}};
    std::for_each(dna.begin(), dna.end(), [&counts](char c) {
        (c == 'A' || c == 'C' || c == 'G' || c == 'T') ? counts[c]++ :
        throw std::invalid_argument("Invalid nucleotide");
    });
    return counts;
}
} // namespace nucleotide_count
