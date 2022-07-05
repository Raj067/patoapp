
from calendar import month_name

from home.models import ShopUser


def format_date(date):
    return f"{date.day} {month_name[date.month]}, {date.year} "


def get_shop(request) -> list:
    shop = [i.shop for i in ShopUser.objects.all() if i.user == request.user]
    return shop
