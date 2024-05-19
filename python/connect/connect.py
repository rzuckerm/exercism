Point = tuple[int, int]


class ConnectGame:
    def __init__(self, board: str):
        board = [line.replace(" ", "") for line in board.splitlines()]
        self.nr, self.nc = len(board), len(board[0])
        self.pts = {p: {(r, c) for r, row in enumerate(board) for c, ch in enumerate(row) if ch == p} for p in "XO"}

    def get_winner(self) -> str:
        for player, pts, pt_func, end_dim1, end_dim2 in [
            ("O", self.pts["O"], lambda a, b: (a, b), self.nr - 1, self.nc),
            ("X", self.pts["X"], lambda a, b: (b, a), self.nc - 1, self.nr),
        ]:
            begin = {pt_func(0, x) for x in range(end_dim2)} & pts
            end = {pt_func(end_dim1, x) for x in range(end_dim2)} & pts
            if any(_is_winner(pts, point, end, set()) for point in begin):
                return player

        return ""


def _is_winner(pts: set[Point], pt: Point, end: set[Point], path: set[Point]) -> bool:
    if pt in end:
        return True

    for move in [(-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0)]:
        new_pt = (pt[0] + move[0], pt[1] + move[1])
        if new_pt in pts and new_pt not in path:
            path.add(new_pt)
            if _is_winner(pts, new_pt, end, path):
                return True

            path.remove(new_pt)

    return False
