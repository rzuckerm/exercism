NUMBER_TYPES = ["perfect", "deficient", "abundant"]


def classify(number):
    """A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """

    if number < 1:
        raise ValueError("Classification is only possible for positive integers.")

    nsqrt = int(number**0.5)
    factor_sum = -number + sum(
        set.union(*[{x, number // x} for x in range(1, nsqrt + 1) if number % x == 0])
    )
    return NUMBER_TYPES[(factor_sum < number) + (factor_sum > number) * 2]
