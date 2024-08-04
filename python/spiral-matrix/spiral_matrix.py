def spiral_matrix(size: int) -> list:
    r, c, n, dr, dc = 0, 0, 1, 0, 1
    matrix = [[0 for _ in range(size)] for _ in range(size)]
    for turns_left in range(2 * size - 1, -1, -1):
        for _ in range((turns_left + 1) // 2):
            matrix[r][c], r, c, n = n, r + dr, c + dc, n + 1

        r, c, dr, dc = r + dc - dr, c - dc - dr, dc, -dr

    return matrix
