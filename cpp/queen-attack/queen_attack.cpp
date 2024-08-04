#include "queen_attack.h"
#include <stdexcept>

namespace queen_attack
{
void validate(const std::pair<int, int> piece)
{
    if (piece.first < 0 || piece.first > 7 || piece.second < 0 || piece.second > 7)
    {
        throw std::domain_error("Invalid position");
    }
}

chess_board::chess_board(const std::pair<int, int> white_, const std::pair<int, int> black_)
    : white_(white_), black_(black_)
{
    validate(white_);
    validate(black_);
    if (white_ == black_)
    {
        throw std::domain_error("White and black cannot occupy same position");
    }
}

std::pair<int, int> chess_board::white() const
{
    return white_;
}

std::pair<int, int> chess_board::black() const
{
    return black_;
}

bool chess_board::can_attack() const
{
    return white_.first == black_.first || white_.second == black_.second ||
           abs(white_.first - black_.first) == abs(white_.second - black_.second);
}
} // namespace queen_attack
