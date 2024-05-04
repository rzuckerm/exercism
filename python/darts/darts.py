RADII_SQ_SCORES = [(1, 10), (25, 5), (100, 1)]


def score(x, y):
    rsq = x * x + y * y
    return next((val for min_rsq, val in RADII_SQ_SCORES if rsq <= min_rsq), 0)
