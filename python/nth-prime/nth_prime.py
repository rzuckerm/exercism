def prime(number: int) -> int:
    if not number:
        raise ValueError("there is no zeroth prime")

    p = 2
    for _ in range(number - 1):
        p += 1 if p == 2 else 2
        while any(p % k == 0 for k in range(3, int(p**0.5) + 1, 2)):
            p += 2

    return p
