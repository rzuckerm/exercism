EAST, NORTH, WEST, SOUTH = (1, 0), (0, 1), (-1, 0), (0, -1)
INSTRUCTIONS = {
    "R": lambda d, c: ((d[1], -d[0]), c),
    "L": lambda d, c: ((-d[1], d[0]), c),
    "A": lambda d, c: (d, (c[0] + d[0], c[1] + d[1])),
}


class Robot:
    def __init__(self, direction: int = NORTH, x_pos: int = 0, y_pos: int = 0):
        self.direction = direction
        self.coordinates = (x_pos, y_pos)

    def move(self, instructions: str):
        for instruction in filter(lambda x: x in INSTRUCTIONS, instructions):
            self.direction, self.coordinates = INSTRUCTIONS[instruction](self.direction, self.coordinates)
