def rebase(input_base: int, digits: list[int], output_base: int):
    if input_base < 2:
        raise ValueError("input base must be >= 2")

    if output_base < 2:
        raise ValueError("output base must be >= 2")

    if any(d < 0 or d >= input_base for d in digits):
        raise ValueError("all digits must satisfy 0 <= d < input base")

    x = (sum(d * input_base**n for n, d in enumerate(reversed(digits))), 0)
    output = []
    while (x := divmod(x[0], output_base)) != (0, 0):
        output.append(x[1])

    return list(reversed(output or [0]))
