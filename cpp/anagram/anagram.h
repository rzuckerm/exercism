#pragma once
#include <string>
#include <vector>

namespace anagram {
class anagram {
   public:
    anagram(const std::string &word);
    std::vector<std::string> matches(const std::vector<std::string> &words);

   private:
    std::string word_;
    std::string letters;
};
}  // namespace anagram
