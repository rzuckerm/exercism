#pragma once

namespace perfect_numbers {
enum class classification { perfect, abundant, deficient };

classification classify(int n);
}  // namespace perfect_numbers
