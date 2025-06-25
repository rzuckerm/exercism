from datetime import datetime, timedelta
import calendar
import re


def delivery_date(start: str, description: str) -> str:
    datetime_value = datetime.fromisoformat(start)
    date_value = datetime_value.replace(hour=0, minute=0, second=0)
    if description == "NOW":
        datetime_value += timedelta(hours=2)
    elif description == "ASAP":
        datetime_value = date_value + timedelta(hours=17 if datetime_value.hour < 13 else 37)
    elif description == "EOW":
        weekday = datetime_value.weekday()
        datetime_value = date_value
        datetime_value += timedelta(days=(4 if weekday <= 2 else 6) - weekday, hours=17 if weekday <= 2 else 20)
    elif match_ := re.fullmatch(r"([1-9]|1[0-2])M", description):
        month = int(match_.group(1))
        year_add = int(datetime_value.month >= month)
        first = datetime(year=datetime_value.year + year_add, month=month, day=1, hour=8)
        weekday = first.weekday()
        datetime_value = first + timedelta(days=(-weekday) % 7 if weekday >= 5 else 0)
    elif match_ := re.fullmatch(r"Q([1-4])", description):
        month = 3 * int(match_.group(1))
        year_add = int(datetime_value.month > month)
        last = datetime(year=datetime_value.year + year_add, month=month, day=1, hour=8)
        last = last.replace(day=calendar.monthrange(last.year, last.month)[1])
        weekday = last.weekday()
        datetime_value = last + timedelta(days=4 - weekday if weekday >= 5 else 0)

    return datetime.isoformat(datetime_value)
