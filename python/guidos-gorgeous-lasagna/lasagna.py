"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""

EXPECTED_BAKE_TIME = 40
PREPARATION_TIME = 2


def bake_time_remaining(elapsed_bake_time: int) -> int:
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """

    return EXPECTED_BAKE_TIME - elapsed_bake_time


def preparation_time_in_minutes(layers: int) -> int:
    """Calculate the preparation time.

    :param layers: int - number of layers.
    :return: int - preparation time (in minutues) derived from 'PREPARATION_TIME'.

    Function that takes the number of layers of lasagna as an argument and returns
    how many minutes of preparation are needed.
    """

    return PREPARATION_TIME * layers


# Remember to add a docstring (you can copy and then alter the one from bake_time_remaining.)
def elapsed_time_in_minutes(layers: int, time: int) -> int:
    """Calculate the elapsed time.

    :param layers: int - number of layers.
    :param time: int - amount of time (in minutes).
    :return: int - elapsed time (in minutes).

    Function that takes the number of layers of lasagna and the amount of time
    (in minutes) and returns the elapsed time (in minutes).
    """

    return time + preparation_time_in_minutes(layers)
