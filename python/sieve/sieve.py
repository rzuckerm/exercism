def primes(limit: int) -> list[int]:
    sieve = [None if (n >= 4 and n % 2 == 0) or n < 2 else n for n in range(limit + 1)]
    for factor in range(3, int(limit**0.5) + 1, 2):
        if sieve[factor]:
            sieve[factor * factor :: factor] = [None] * ((limit - factor * factor) // factor + 1)

    return [n for n in sieve if n]
