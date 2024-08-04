#include <array>
#include <string>
#include <vector>

// Round down all provided student scores.
std::vector<int> round_down_scores(std::vector<double> student_scores)
{
    std::vector<int> rounded_scores;
    for (auto score : student_scores)
    {
        rounded_scores.emplace_back(static_cast<int>(score));
    }

    return rounded_scores;
}

// Count the number of failing students out of the group provided.
int count_failed_students(std::vector<int> student_scores)
{
    int failing_students{0};
    for (auto score : student_scores)
    {
        failing_students += (score <= 40) ? 1 : 0;
    }

    return failing_students;
}

// Determine how many of the provided student scores were 'the best' based on the provided threshold.
std::vector<int> above_threshold(std::vector<int> student_scores, int threshold)
{
    std::vector<int> best_scores;
    for (auto score : student_scores)
    {
        if (score >= threshold)
        {
            best_scores.emplace_back(score);
        }
    }

    return best_scores;
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, 4> letter_grades(int highest_score)
{
    std::array<int, 4> grades;
    for (int i = 0; i < 4; i++)
    {
        grades[i] = 41 + (highest_score - 40) * i / 4;
    }

    return grades;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string> student_ranking(std::vector<int> student_scores, std::vector<std::string> student_names)
{
    std::vector<std::string> ranking;
    for (size_t i = 0; i < student_scores.size(); i++)
    {
        ranking.emplace_back(std::to_string(i + 1) + ". " + student_names[i] + ": " + std::to_string(student_scores[i]));
    }

    return ranking;
}

// Create a string that contains the name of the first student to make a perfect score on the exam.
std::string perfect_score(std::vector<int> student_scores, std::vector<std::string> student_names)
{
    std::string perfect_student{""};
    for (size_t i = 0; (i < student_scores.size()) && perfect_student == ""; i++)
    {
        if (student_scores[i] == 100)
        {
            perfect_student = student_names[i];
        }
    }

    return perfect_student;
}
