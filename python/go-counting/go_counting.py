CoordT = tuple[int, int]
WHITE, BLACK, NONE = "W", "B", " "


class Board:
    def __init__(self, board: list[str]):
        self.board, self.num_rows, self.num_cols = board, len(board), len(board[0])

    def territory(self, x: int, y: int) -> tuple[str, set[CoordT]]:
        if not self._is_valid(x, y):
            raise ValueError("Invalid coordinate")

        stack, owners, territory = [(x, y)], set(), set()
        while stack:
            x, y = stack.pop()
            if self._is_valid(x, y) and (x, y) not in territory:
                stone = self.board[y][x]
                if stone == NONE:
                    territory.add((x, y))
                    stack += [(x, y - 1), (x - 1, y), (x, y + 1), (x + 1, y)]
                else:
                    owners.add(stone)

        return owners.pop() if len(owners) == 1 and territory else NONE, territory

    def territories(self) -> dict[str, set[CoordT]]:
        result = {owner: set() for owner in [BLACK, WHITE, NONE]}
        visited = set()
        for x in range(self.num_cols):
            for y in range(self.num_rows):
                if (x, y) not in visited:
                    owner, territory = self.territory(x, y)
                    result[owner] |= territory
                    visited |= territory

        return result

    def _is_valid(self, x: int, y: int) -> bool:
        return 0 <= x < self.num_cols and 0 <= y < self.num_rows
