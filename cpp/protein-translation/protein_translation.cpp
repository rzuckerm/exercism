#include "protein_translation.h"
#include <map>

namespace protein_translation
{
static std::map<std::string, std::string> proteins_table{
    {"AUG", "Methionine"}, {"UUU", "Phenylalanine"}, {"UUC", "Phenylalanine"}, {"UUA", "Leucine"},
    {"UUG", "Leucine"},    {"UCU", "Serine"},        {"UCC", "Serine"},        {"UCA", "Serine"},
    {"UCG", "Serine"},     {"UAU", "Tyrosine"},      {"UAC", "Tyrosine"},      {"UGU", "Cysteine"},
    {"UGC", "Cysteine"},   {"UGG", "Tryptophan"},
};

std::vector<std::string> proteins(const std::string &codons)
{
    std::vector<std::string> p;
    for (size_t i = 0; i < codons.size(); i += 3)
    {
        auto iter = proteins_table.find(codons.substr(i, 3));
        if (iter == proteins_table.end())
        {
            break;
        }

        p.emplace_back(iter->second);
    }

    return p;
}
} // namespace protein_translation
