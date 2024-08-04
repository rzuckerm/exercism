from datetime import date, timedelta

DAYS = {"Monday": 0, "Tuesday": 1, "Wednesday": 2, "Thursday": 3, "Friday": 4, "Saturday": 5, "Sunday": 6}
WEEKS = {"first": 0, "second": 1, "third": 2, "fourth": 3, "fifth": 4, "last": -1, "teenth": 0}


class MeetupDayException(ValueError):
    pass


def meetup(year: int, month: int, week: str, day_of_week: str) -> date:
    month_offset, day = 1 if week == "last" else 0, 13 if week == "teenth" else 1
    d = date(year + (month + month_offset - 1) // 12, (month + month_offset - 1) % 12 + 1, day)
    d += timedelta(weeks=WEEKS[week], days=(DAYS[day_of_week] - d.weekday()) % 7)
    if d.month != month:
        raise MeetupDayException("That day does not exist.")

    return d
