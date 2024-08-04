#pragma once
#include <map>
#include <string>
#include <vector>

namespace grade_school
{
class school
{
  public:
    school();
    std::map<int, std::vector<std::string>> roster() const;
    void add(const std::string &name, int grade);
    std::vector<std::string> grade(int grade) const;

  private:
    std::map<int, std::vector<std::string>> students;
};
} // namespace grade_school
