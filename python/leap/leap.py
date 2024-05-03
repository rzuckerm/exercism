def leap_year(year: int) -> bool:
    """
    Indicate whether this is a leap year

    :param year: Year
    :return: True if leap year, False otherwise
    """

    return year % 400 == 0 or (year % 4 == 0 and year % 100 != 0)
