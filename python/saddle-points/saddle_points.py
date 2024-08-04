def saddle_points(matrix: list[list[int]]) -> dict[str, int]:
    if any(len(row) != len(matrix[0]) for row in matrix):
        raise ValueError("irregular matrix")

    maxes = [max(row) for row in matrix]
    mins = [min(col) for col in zip(*matrix)]
    return [{"row": i + 1, "column": j + 1} for i, mx in enumerate(maxes) for j, mn in enumerate(mins) if mx == mn]
