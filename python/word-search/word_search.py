from dataclasses import dataclass

DIRS = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]


@dataclass
class Point:
    x: int
    y: int


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
