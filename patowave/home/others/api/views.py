
from home.models import *
from .functions.func import get_shop
from .serializer import *
from rest_framework.response import Response

from django.http import FileResponse, HttpResponse, JsonResponse
# from rest_framework.views import APIView
from rest_framework import status
# from rest_framework.permissions import IsAdminUser
# from accounts.models import CustomUser
# from rest_framework.permissions import AllowAny

from rest_framework.decorators import api_view, permission_classes


@api_view(['GET'])
def top_selling_items(request, *args, **kwargs):
    data = top_selling_items_data(request, get_shop(request))
    return Response(data)


@api_view(['GET'])
def general_inventory_analysis(request, *args, **kwargs):
    data = general_inventory_analysis_data(request, get_shop(request))
    return Response(data)


@api_view(['GET'])
def general_parties_details(request, *args, **kwargs):
    data = general_parties_data(request, get_shop(request))
    return Response(data)

#  =============FOR BUSINESS ==========


@api_view(['GET'])
def general_business_details(request, *args, **kwargs):
    data = general_business_data(request, get_shop(request))
    return Response(data)


@api_view(['GET'])
def business_financial_transactions(request, *args, **kwargs):
    data = business_financial_data(request, get_shop(request))
    return Response(data)


@api_view(['POST'])
def deleting_single_transaction_api(request):
    if request.method == "POST":
        print(request.data)
        # data = Customer.objects.get(id=request.data.get("id"))
        # data.customer_name = request.data.get("customerName")
        # data.customer_number = request.data.get("phoneNumber")
        # data.customer_email = request.data.get("address")
        # data.customer_address = request.data.get("emailAddress")
        # data.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)

# ==================================


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


@api_view(['GET'])
def parties_details_api(request):
    data = [dx for dx in Customer.objects.all() if dx.shop in get_shop(request)]
    serializer = CustomerSerializer(data, many=True)
    return Response(serializer.data)


@api_view(['GET'])
def greeting_cards(request, *args, **kwargs):
    data = GreetingCard.objects.all()
    serializer = GreetingCardSerializer(data, many=True)
    return Response(serializer.data)

# ----------- FOR CUSTOMER ----------------


@api_view(['POST'])
def add_new_customer_api(request):
    if request.method == "POST":
        reg = Customer(
            shop=get_shop(request)[0],
            customer_name=request.data.get('customerName'),
            customer_number=request.data.get('phoneNumber'),
            customer_email=request.data.get('emailAddress'),
            customer_address=request.data.get('address'),
        )
        reg.save()
        if request.data.get("openingBalance") > 0:
            reg.customer_payment.create(
                shop=get_shop(request)[0],
                customer=reg,
                is_payment_in=request.data.get("toReceive"),
                description="Opening Balance",
                amount=request.data.get("openingBalance"),
            )
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def edit_existing_customer_api(request):
    if request.method == "POST":
        data = Customer.objects.get(id=request.data.get("id"))
        data.customer_name = request.data.get("customerName")
        data.customer_number = request.data.get("phoneNumber")
        data.customer_email = request.data.get("address")
        data.customer_address = request.data.get("emailAddress")
        data.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def adding_payment_customer_api(request):
    if request.method == "POST":
        data = Customer.objects.get(id=request.data.get("id"))
        data.customer_payment.create(
            shop=get_shop(request)[0],
            customer=data,
            is_payment_in=request.data.get("isPaymentIn"),
            description=request.data.get("description"),
            amount=request.data.get("amount"),
            receipt_no=str(request.data.get('receiptNo')),
        )
        data.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)

# FOR TRANSACTIONS - SALES


@api_view(['POST'])
def cash_sales_transaction_api(request):
    if request.method == "POST":
        # print(request.data)
        amount = request.data.get('amount')
        discount = request.data.get('discount')
        items = request.data.get('items')
        reg = CashSale(
            shop=get_shop(request)[0],
            amount=amount,
            discount=discount,
            receipt_no=str(request.data.get('receiptNo')),
        )

        reg.save()
        for dx in items:
            reg.sold_items.create(
                shop=get_shop(request)[0],
                product=Product.objects.get(id=dx.get('id')),
                price=dx.get('price'),
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                cash_sale_data=reg,
            )
            # Once transaction completed
            # successfully, decreasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity - dx.get('quantity')
            prod.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def cash_sales_customer_transaction_api(request):
    if request.method == "POST":
        amount = request.data.get('amount')
        discount = request.data.get('discount')
        customer = request.data.get('customer')
        items = request.data.get('items')
        reg = CashSaleCustomer(
            shop=get_shop(request)[0],
            amount=amount,
            discount=discount,
            customer=Customer.objects.get(id=customer),
            receipt_no=str(request.data.get('receiptNo')),
        )
        reg.save()

        for dx in items:
            reg.sold_items.create(
                shop=get_shop(request)[0],
                product=Product.objects.get(id=dx.get('id')),
                price=dx.get('price'),
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                cash_sale_customer=reg,
            )
            # Once transaction completed
            # successfully, decreasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity - dx.get('quantity')
            prod.save()

        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)
