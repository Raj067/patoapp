from django.http import JsonResponse
from backend.api.customers import *
from backend.funcs.decorators import *
from backend.api.shop import *
from backend.api.product import *
from home.models import *
from .serializers import *


def get_shop(request):
    shop = [i.shop for i in ShopUser.objects.all() if i.user == request.user]
    return shop


def main_shop_details(request, *args, **kwargs):
    return main_shop_details_der(request)


def inventory_pruducts_api(request):
    data = [dx for dx in Product.objects.all() if dx.shop in get_shop(request)]
    serializer = ProductSerializer(data, many=True)
    return JsonResponse(serializer.data, safe=False)


def parties_details_api(request):
    data = [dx for dx in Customer.objects.all() if dx.shop in get_shop(request)]
    serializer = CustomerSerializer(data, many=True)
    return JsonResponse(serializer.data, safe=False)

# ................ SHOP APIs ...........................


# @authenticated_api
# def add_new_shop(request, *args, **kwargs):
#     if request.method == 'POST':
#         return add_new_shop_der(request)
#     data = {}
#     return JsonResponse(data=data, safe=False)


# @authenticated_api
# def edit_existing_shop(request, shop_id, *args, **kwargs):
#     if request.method == 'POST':
#         return edit_existing_shop_der(request, shop_id)
#     data = {}
#     return JsonResponse(data=data, safe=False)


# @authenticated_api
# def delete_existing_shop(request, shop_id, *args, **kwargs):
#     if request.method == 'POST':
#         shop = Shop.objects.get(id=shop_id)
#         shop.delete()
#     data = {}
#     return JsonResponse(data=data, safe=False)

# # ................... PRODUCT APIs ............................


# @authenticated_api
# def add_new_product(request, *args, **kwargs):
#     if request.method == 'POST':
#         return add_new_product_der(request)
#     data = {}
#     return JsonResponse(data=data, safe=False)


# @authenticated_api
# def edit_existing_product(request, product_id, *args, **kwargs):
#     if request.method == 'POST':
#         return edit_existing_product_der(request, product_id)
#     data = {}
#     return JsonResponse(data=data, safe=False)


# @authenticated_api
# def delete_existing_product(request, product_id, *args, **kwargs):
#     if request.method == 'POST':
#         product = Product.objects.get(id=product_id)
#         product.delete()
#     data = {}
#     return JsonResponse(data=data, safe=False)


# # @authenticated_api
# def all_shop_products(request, *args, **kwargs):
#     # if not get_shop(request):
#     #     return JsonResponse(data={'response': [], 'status': 505}, safe=False)

#     # shop = get_shop(request)[0]
#     product = [i for i in Product.objects.all()]  # if i.shop == shop]
#     data = {'response': [
#         {'product_name': i.product_name, 'product_code': i.product_code,
#          'purchases_price': i.purchases_price, 'selling_price': i.selling_price,
#          'quantity': i.quantity, 'stock': i.stock} for i in product],
#         'status': 404
#     }
#     return JsonResponse(data=data, safe=False)


# @authenticated_api
# def single_shop_product(request, product_id, * args, **kwargs):
#     i = Product.objects.get(id=product_id)
#     data = {'response': {'product_name': i.product_name, 'product_code': i.product_code,
#             'purchases_price': i.purchases_price, 'selling_price': i.selling_price,
#                          'quantity': i.quantity, 'stock': i.stock},
#             'status': 404}
#     return JsonResponse(data=data, safe=False)

# # ................... CUSTOMERS DETAILS .......................


# @authenticated_api
# def all_shop_customers(request, *args, **kwargs):
#     if not get_shop(request):
#         return JsonResponse(data={'response': [], 'status': 505}, safe=False)
#     shop = get_shop(request)[0]
#     return all_shop_customers_der(request, shop)
