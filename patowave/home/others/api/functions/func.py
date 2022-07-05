
from calendar import month_name


def format_date(date):
    return f"{date.day} {month_name[date.month]}, {date.year} "
