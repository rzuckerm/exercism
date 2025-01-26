#include "power_of_troy.h"

#include <algorithm>

namespace troy {
void give_new_artifact(human &recipient, const std::string &name) {
    recipient.possession = std::make_unique<artifact>(artifact(name));
}

void exchange_artifacts(std::unique_ptr<artifact> &artifact1, std::unique_ptr<artifact> &artifact2) {
    artifact1.swap(artifact2);
}

void manifest_power(human &recipient, const std::string &effect) {
    recipient.own_power = std::make_shared<power>(power(effect));
}

void use_power(human &caster, human &target) { target.influenced_by = caster.own_power; }

int power_intensity(const human &person) { return person.own_power.use_count(); }
}  // namespace troy
