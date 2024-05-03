""" Determine triangle types """

NumberT = int | float


def equilateral(sides: list[NumberT]) -> bool:
    """
    Indicate if equilateral triangle

    :param sides: Triangle sides
    :return: True if equilateral triange, False otherwise
    """

    return _is_valid_triangle(sides) and len(set(sides)) == 1


def isosceles(sides):
    """
    Indicate if isosceles triangle

    :param sides: Triangle sides
    :return: True if isosceles triange, False otherwise
    """

    return _is_valid_triangle(sides) and len(set(sides)) <= 2


def scalene(sides):
    """
    Indicate if scalene triangle

    :param sides: Triangle sides
    :return: True if scalene triange, False otherwise
    """

    return _is_valid_triangle(sides) and len(set(sides)) == 3


def _is_valid_triangle(sides: list[NumberT]) -> bool:
    return (
        all(side > 0 for side in sides)
        and sides[0] + sides[1] > sides[2]
        and sides[1] + sides[2] > sides[0]
        and sides[0] + sides[2] > sides[1]
    )
