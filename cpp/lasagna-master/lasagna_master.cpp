#include "lasagna_master.h"
#include <algorithm>

namespace lasagna_master
{
int preparationTime(const std::vector<std::string> &layers, int time)
{
    return layers.size() * time;
}

int count_layers(const std::vector<std::string> &layers, const std::string &item)
{
    return int(std::count_if(layers.begin(), layers.end(), [item](const std::string &layer) { return layer == item; }));
}

amount quantities(const std::vector<std::string> &layers)
{
    return amount{50 * count_layers(layers, "noodles"), 0.2 * count_layers(layers, "sauce")};
}

void addSecretIngredient(std::vector<std::string> &myList, const std::vector<std::string> &friendsList)
{
    myList.back() = friendsList.back();
}

void addSecretIngredient(std::vector<std::string> &myList, const std::string &secretIngredient)
{
    myList.back() = secretIngredient;
}

std::vector<double> scaleRecipe(const std::vector<double> &quantities, int servings)
{
    std::vector<double> newQuantities(quantities.size());
    std::transform(quantities.begin(), quantities.end(), newQuantities.begin(),
                   [servings](const double quantity) { return quantity * servings / 2.0; });
    return newQuantities;
}
} // namespace lasagna_master
