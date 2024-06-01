DIRS = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]


class Point:
    def __init__(self, x: int, y: int):
        self.x, self.y = x, y

    def __eq__(self, other) -> bool:
        return (self.x, self.y) == (other.x, other.y)


class WordSearch:
    def __init__(self, puzzle: list[str]):
        self.puzzle, self.xmax, self.ymax = puzzle, len(puzzle[0]), len(puzzle)

    def search(self, word: str) -> tuple[Point, Point] | None:
        w = len(word) - 1
        for y, row in enumerate(self.puzzle):
            x = -1
            while (x := row.find(word[0], x + 1)) >= 0:
                for dx, dy in DIRS:
                    if 0 <= x + dx * w < self.xmax and 0 <= y + dy * w < self.ymax:
                        if all(self.puzzle[y + n * dy][x + n * dx] == ch for n, ch in enumerate(word)):
                            return Point(x, y), Point(x + dx * w, y + dy * w)

        return None
