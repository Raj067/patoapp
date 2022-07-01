from home.models import *


def get_shop(request):
    return [i.shop for i in ShopUser.objects.all() if i.user == request.user]


def add_new_shop_der(request):
    name = request.POST.get('shopName')
    slogan = request.POST.get('sloganName')
    phone = request.POST.get('phoneName')

    # Shop(
    #     name=name, slogan=slogan, phone=phone,
    # ).save()
    return 0


def edit_existing_shop_der(request,  shop_id):
    name = request.POST.get('shopName')
    slogan = request.POST.get('sloganName')
    phone = request.POST.get('phoneName')

    shop = Shop.objects.get(id=shop_id)
    shop.name = name
    shop.slogan = slogan
    shop.phone = phone

    shop.save()
    return 0
