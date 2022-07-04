from django.http import JsonResponse
from backend.api.customers import *
from backend.funcs.decorators import *
from home.models import *
from .serializers import *

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from accounts.models import CustomUser


from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes


# @api_view()
# @permission_classes([AllowAny],)
def sample_api(request):
    print("request received", request)
    print(f'{request.user.is_authenticated}')
    return JsonResponse({"data": "hello"})


class UserRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        users = CustomUser.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )


def get_shop(request) -> list:
    shop = [i.shop for i in ShopUser.objects.all() if i.user == request.user]
    return shop


@api_view(['GET'])
def shop_profile_details(request, *args, **kwargs):
    data = get_shop(request)[0]if get_shop(request) else []
    serializer = ShopProfileSerializer(data, many=False)
    return Response(serializer.data)


@api_view(['GET', 'POST'])
def inventory_pruducts_api(request):
    data = [dx for dx in Product.objects.all() if dx.shop in get_shop(request)]
    serializer = ProductSerializer(data, many=True)
    return Response(serializer.data)


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
