#pragma once
#include <string>

namespace rna_transcription
{
char to_rna(char codon);
std::string to_rna(const std::string &dna);
} // namespace rna_transcription
