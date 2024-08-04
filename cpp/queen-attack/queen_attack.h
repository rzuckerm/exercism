#pragma once
#include <utility>

namespace queen_attack
{
class chess_board
{
  public:
    chess_board(const std::pair<int, int> white_, const std::pair<int, int> black_);
    std::pair<int, int> white() const;
    std::pair<int, int> black() const;
    bool can_attack() const;

  private:
    std::pair<int, int> white_;
    std::pair<int, int> black_;
};
} // namespace queen_attack
