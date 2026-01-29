DIRECTIONS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]


def tick(matrix):
    return [
        [
            1 if (cell == 1 and num_live in [2, 3]) or (cell == 0 and num_live == 3) else 0
            for c, cell in enumerate(row)
            for num_live in [_count_live_neighbors(matrix, r, c)]
        ]
        for r, row in enumerate(matrix)
    ]


def _is_valid_neighbor(matrix, r, c):
    return 0 <= r < len(matrix) and 0 <= c < len(matrix[0])


def _count_live_neighbors(matrix, r, c):
    return sum(_is_valid_neighbor(matrix, r + dr, c + dc) and matrix[r + dr][c + dc] == 1 for dr, dc in DIRECTIONS)
