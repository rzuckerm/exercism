#include "grade_school.h"
#include <algorithm>

namespace grade_school
{
school::school()
{
}

std::map<int, std::vector<std::string>> school::roster() const
{
    return students;
}

void school::add(const std::string &name, int grade)
{
    students[grade].emplace_back(name);
    std::sort(students[grade].begin(), students[grade].end());
}

std::vector<std::string> school::grade(int grade) const
{
    auto iter = students.find(grade);
    return (iter == students.end()) ? std::vector<std::string>() : iter->second;
}
} // namespace grade_school
