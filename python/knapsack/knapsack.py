def maximum_value(maximum_weight: int, items: list[dict[str, int]]) -> int:
    m: list[int] = [0] * (maximum_weight + 1)
    for item in items:
        for j in range(maximum_weight, item["weight"] - 1, -1):
            m[j] = max(m[j], m[j - item["weight"]] + item["value"])

    return m[maximum_weight]
