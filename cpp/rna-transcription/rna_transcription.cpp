#include "rna_transcription.h"
#include <map>
#include <numeric>
namespace rna_transcription
{

static std::map<char, char> rna_table{{{'G', 'C'}, {'C', 'G'}, {'T', 'A'}, {'A', 'U'}}};

char to_rna(char codon)
{
    return rna_table[codon];
}

std::string to_rna(const std::string &dna)
{
    return std::accumulate(dna.begin(), dna.end(), std::string(),
                           [](std::string rna, char codon) { return rna + std::string(1, to_rna(codon)); });
}
} // namespace rna_transcription
