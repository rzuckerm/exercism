#include "allergies.h"
#include <vector>

namespace allergies
{
static std::string allergens[] = {"eggs",     "peanuts",   "shellfish", "strawberries",
                                  "tomatoes", "chocolate", "pollen",    "cats"};

allergy_test::allergy_test(unsigned int code)
{
    for (unsigned int n = 0; n < 8; n++)
    {
        if (code & (1 << n))
        {
            allergies.insert(allergens[n]);
        }
    }
}

bool allergy_test::is_allergic_to(const std::string &allegen) const
{
    return allergies.find(allegen) != allergies.end();
}

std::unordered_set<std::string> allergy_test::get_allergies() const
{
    return allergies;
}
} // namespace allergies
