from tokenize import String
from home.models import *
from .functions.func import get_shop
from .serializer import *
from rest_framework.response import Response
from rest_framework import status
from accounts.models import CustomUser
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
from rest_framework_simplejwt.tokens import RefreshToken


@api_view(['GET', 'POST'])
@permission_classes([AllowAny])
def signup_user(request, *args, **kwargs):
    if request.method == "POST":
        user = CustomUser(
            username=request.data.get("username")
        )
        user.set_password(request.data.get("password"))
        try:
            user.save()
        except:
            # User already exist
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        refresh = RefreshToken.for_user(user)

        data = {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }
        return Response(data=data, status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def setting_account_api(request):
    if request.method == "POST":
        shop = Shop(
            name=request.data.get('businessName'),
            instagram_name=request.data.get('instagramName'),
            email=request.data.get('businessEmail'),
            address=request.data.get('businessAddress'),
        )
        shop.save()
        shop_user = ShopUser(
            shop=shop,
            user=request.user,
        )
        shop_user.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


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
        # print(request.data)
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
    data = get_shop(request)  # [0]if get_shop(request) else None
    serializer = ShopProfileSerializer(data, many=True)
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

# FOR TRANSACTIONS - Expenses & Purchases


@api_view(['POST'])
def purchases_transaction_api(request):
    if request.method == "POST":
        # print(request.data)
        amount_paid = request.data.get('amount_paid')
        total_amount = request.data.get('total_amount')
        customer = request.data.get('customer')
        billNo = request.data.get('billNo')
        items = request.data.get('items')
        description = request.data.get('description')
        reg = Purchase(
            shop=get_shop(request)[0],
            amount_paid=amount_paid,
            total_amount=total_amount,
            bill_no=str(billNo),
            description=description,
        )
        reg.save()
        if customer:
            reg.customer = Customer.objects.get(id=customer)
            reg.save()

        for dx in items:
            reg.purchased_items.create(
                shop=get_shop(request)[0],
                product=Product.objects.get(id=dx.get('id')),
                price=dx.get('price'),
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                purchases_data=reg,
            )
            # Once transaction completed
            # successfully, increasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity + dx.get('quantity')
            prod.save()

        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def expenses_transaction_api(request):
    if request.method == "POST":
        # print(request.data)
        amount = request.data.get('amount_paid')
        category = request.data.get('category')
        customer = request.data.get('customer')
        billNo = request.data.get('billNo')
        description = request.data.get('description')
        reg = Expense(
            shop=get_shop(request)[0],
            amount=amount,
            bill_no=str(billNo),
            description=description,
            expenses_category=category,
        )
        reg.save()
        if customer:
            reg.customer = Customer.objects.get(id=customer)
            reg.save()

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
        #
        reg = CashSale(
            shop=get_shop(request)[0],
            amount=amount,
            discount=discount,
            # description=description,
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
        description = request.data.get('description')
        reg = CashSaleCustomer(
            shop=get_shop(request)[0],
            amount=amount,
            discount=discount,
            description=description,
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

# For products


@api_view(['POST'])
def add_new_product_api(request):
    if request.method == "POST":
        product = Product(
            shop=get_shop(request)[0],
            product_name=request.data.get('productName'),
            quantity=request.data.get('quantity'),
            purchases_price=request.data.get('purchasesPrice'),
            selling_price_primary=request.data.get('sellingPrice'),
            stock_level=request.data.get('stockLevel'),
            primary_unit=request.data.get('primaryUnit'),
            is_service=request.data.get('isService'),
            supplier_name=request.data.get('supplierName'),
            supplier_number=request.data.get('supplierNumber'),
            supplier_email=request.data.get('supplierEmail'),
        )
        product.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def edit_product_api(request):
    if request.method == "POST":
        product = Product.objects.get(id=request.data.get('id'))
        product.product_name = request.data.get('productName')
        product.quantity = request.data.get('quantity')
        product.purchases_price = request.data.get('purchasesPrice')
        product.selling_price_primary = request.data.get('sellingPrice')
        product.stock_level = request.data.get('stockLevel')
        product.primary_unit = request.data.get('primaryUnit')
        product.supplier_name = request.data.get('supplierName')
        product.supplier_number = request.data.get('supplierNumber')
        product.supplier_email = request.data.get('supplierEmail')
        product.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_new_product_api(request):
    if request.method == "POST":
        product = Product(
            shop=get_shop(request)[0],
            product_name=request.data.get('productName'),
            quantity=request.data.get('quantity'),
            purchases_price=request.data.get('purchasesPrice'),
            selling_price_primary=request.data.get('sellingPrice'),
            stock_level=request.data.get('stockLevel'),
            primary_unit=request.data.get('primaryUnit'),
            is_service=request.data.get('isService'),
            supplier_name=request.data.get('supplierName'),
            supplier_number=request.data.get('supplierNumber'),
            supplier_email=request.data.get('supplierEmail'),
        )
        product.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def delete_product_api(request):
    if request.method == "POST":
        product = Product.objects.get(id=request.data.get('id'))
        product.delete()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def adjust_product_api(request):
    if request.method == "POST":
        product = Product.objects.get(id=request.data.get('id'))
        product.quantity = request.data.get('quantity')
        product.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)
