# Number the board like this:
#
# 0 | 1 | 2
# - + - + -
# 3 | 4 | 5
# - + - + -
# 6 | 7 | 8
#
# Each item is a list of positions that a piece must occupy to win
WINS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]


def gamestate(board):
    board_str = "".join(board)
    num_x, num_o = board_str.count("X"), board_str.count("O")
    if num_x > num_o + 1:
        raise ValueError("Wrong turn order: X went twice")

    if num_o > num_x:
        raise ValueError("Wrong turn order: O started")

    win_x, win_o = [any(all(board_str[pos] == piece for pos in win) for win in WINS) for piece in "XO"]
    if (win_x and num_x != num_o + 1) or (win_o and num_x != num_o):
        raise ValueError("Impossible board: game should have ended after the game was won")

    return "win" if win_x or win_o else "ongoing" if num_x + num_o < 9 else "draw"
