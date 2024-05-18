from dataclasses import dataclass, field

Point = tuple[int, int]
PointsInLine = set[int]


@dataclass
class Connections:
    h_conns: PointsInLine = field(default_factory=set)
    v_conns: PointsInLine = field(default_factory=set)


def rectangles(lines: list[str]) -> int:
    conns = find_conns(lines)
    return count_rectangles(conns)


def find_conns(lines: list[str]) -> dict[Point, Connections]:
    # Find horizonal connections
    conns: dict[Point, Connections] = {}
    for r, line in enumerate(lines):
        curr_col: int | None = None
        for c, ch in enumerate(line):
            if ch == "+":
                conns[(r, c)] = Connections()
                if curr_col is None:
                    curr_col = c
                else:
                    for c2 in conns[(r, curr_col)].h_conns:
                        conns[(r, c2)].h_conns.add(c)

                    conns[(r, curr_col)].h_conns.add(c)
            elif ch != "-":
                curr_col = None

    # Find vertical connections
    num_rows = len(lines)
    num_cols = max((len(line) for line in lines), default=0)
    for c in range(num_cols):
        curr_row: int | None = None
        for r in range(num_rows):
            ch = lines[r][c] if c < len(lines[r]) else " "
            if ch == "+":
                if curr_row is None:
                    curr_row = r
                else:
                    for r2 in conns[(curr_row, c)].v_conns:
                        conns[(r2, c)].v_conns.add(r)

                    conns[(curr_row, c)].v_conns.add(r)
            elif ch != "|":
                curr_row = None

    return conns


def count_rectangles(conns: dict[Point, Connections]) -> int:
    #    a            b
    # (r1, c1) --- (r1, c2)
    #    |            |
    # (r2, c1) --- (r2, c2)
    #    c            d
    #
    # Rectangle if all the following are true:
    # - Point d exists
    # - Point b and d are connected
    # - Point c and d are connected
    return sum(
        (r2, c2) in conns and r2 in conns[(r1, c2)].v_conns and c2 in conns[(r2, c1)].h_conns
        for (r1, c1), pt_conns in conns.items()
        for r2 in pt_conns.v_conns
        for c2 in pt_conns.h_conns
    )
