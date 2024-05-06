def sum_of_multiples(limit, multiples):
    return sum({n for m in multiples if m > 0 for n in range(m, limit, m)})
