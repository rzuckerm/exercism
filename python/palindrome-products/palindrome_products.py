from typing import Callable

PalindromeResultT = tuple[int | None, list[list[int]]]
CompareFuncT = Callable[[int, int], bool]


def largest(min_factor: int, max_factor: int) -> PalindromeResultT:
    """Given a range of numbers, find the largest palindromes which
       are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
             Iterable should contain both factors of the palindrome in an arbitrary order.
    """

    return _find_palindromes(max_factor, min_factor - 1, -1, lambda a, b: a >= b)


def smallest(min_factor: int, max_factor: int) -> PalindromeResultT:
    """Given a range of numbers, find the smallest palindromes which
    are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
    Iterable should contain both factors of the palindrome in an arbitrary order.
    """

    return _find_palindromes(min_factor, max_factor + 1, 1, lambda a, b: a <= b)


def _find_palindromes(start: int, end: int, inc: int, comp_func: CompareFuncT) -> PalindromeResultT:
    if start * inc >= end * inc:
        raise ValueError("min must be <= max")

    result = None
    factors = []
    for i in range(start, end, inc):
        any_change = False
        for j in range(i, end, inc):
            n = i * j
            if not result or comp_func(n, result):
                any_change = True
                nstr = str(n)
                if nstr == nstr[::-1]:
                    if n != result:
                        factors = []

                    result = n
                    factors.append([i, j])

            if not any_change:
                break

    return (result, factors)
