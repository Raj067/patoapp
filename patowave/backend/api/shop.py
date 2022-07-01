from django.http import JsonResponse
from home.models import *
from rest_framework.decorators import api_view
from rest_framework.response import Response

from home.others.api.serializers import MainShopDetailsSerializer


def get_shop(request):
    return [i.shop for i in ShopUser.objects.all() if i.user == request.user]


def main_shop_details_der(request):
    data = Shop.objects.all()
    serializer = MainShopDetailsSerializer(data, many=True)
    return Response(serializer.data)

# from home.others.api.serializers import *


# def get_shop(request):
#     return [i.shop for i in ShopUser.objects.all() if i.user == request.user]


# def main_shop_details_der(request):
#     data = get_shop(request)[0]
#     serializer = MainShopDetailsSerializer(data, many=True)
#     return Response(serializer.data)


# def add_new_shop_der(request):
#     name = request.POST.get('shopName')
#     slogan = request.POST.get('sloganName')
#     phone = request.POST.get('phoneName')

#     # Shop(
#     #     name=name, slogan=slogan, phone=phone,
#     # ).save()
#     return 0


# def edit_existing_shop_der(request,  shop_id):
#     name = request.POST.get('shopName')
#     slogan = request.POST.get('sloganName')
#     phone = request.POST.get('phoneName')

#     shop = Shop.objects.get(id=shop_id)
#     shop.name = name
#     shop.slogan = slogan
#     shop.phone = phone

#     shop.save()
#     return 0
