
from home.models import *


def get_shop(request) -> list:
    # shop = [i.shop for i in ShopUser.objects.all() if i.user ==
    #         request.user]
    shop_user = ShopUser.objects.filter(user=request.user)
    shop = [i.shop for i in shop_user]
    return shop
