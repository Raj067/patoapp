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
import datetime
import random


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
            # default phone number is that of user
            phone=request.user.username
        )
        shop.save()
        shop_user = ShopUser(
            shop=shop,
            user=request.user,
        )
        shop_user.save()
        return Response(status=status.HTTP_201_CREATED, data={'id': shop.id})
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def top_selling_items(request, *args, **kwargs):
    data = top_selling_items_data(request, get_shop(request))
    return Response(data)


@api_view(['GET'])
def general_inventory_analysis(request, *args, **kwargs):
    data = general_inventory_analysis_data(request, get_shop(request))
    return Response(data)


#  =============FOR BUSINESS ==========


@api_view(['GET'])
def business_financial_transactions(request, *args, **kwargs):
    data = business_financial_data(request, get_shop(request))
    return Response(data)


@api_view(['POST'])
def deleting_single_transaction_api(request):
    if request.method == "POST":
        transaction_id = request.data.get('id')
        transaction = request.data.get('transaction')
        items = request.data.get('itemsId')
        transaction_id = transaction_id.split('-')[-1]

        if transaction == 'payment':
            Payment.objects.get(id=int(transaction_id)).delete()

        elif transaction == 'expenses':
            Expense.objects.get(id=int(transaction_id)).delete()

        elif transaction == 'cash_sale':
            # reversing all the quantity sold
            for dx in items:
                item = CashSoldItem.objects.get(id=dx)
                try:
                    prod = Product.objects.get(id=item.id)
                    prod.quantity = prod.quantity + item.quantity
                    prod.save()
                except:
                    pass
                item.delete()
            CashSale.objects.get(id=int(transaction_id)).delete()
        elif transaction == 'cash_sale_customer':
            # reversing all the quantity sold
            for dx in items:
                item = CashSoldItemCustomer.objects.get(id=dx)
                try:
                    prod = Product.objects.get(id=item.id)
                    prod.quantity = prod.quantity + item.quantity
                    prod.save()
                except:
                    pass
                item.delete()
            CashSaleCustomer.objects.get(id=int(transaction_id)).delete()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)

# ========= Shedule=======================


@api_view(['GET'])
def shedule_details(request, *args, **kwargs):
    data = [i for i in Shedule.objects.all() if i.user == request.user]
    serializer = SheduleProfileSerializer(data, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def add_shedule(request):
    if request.method == "POST":
        shedule = Shedule(
            user=request.user,
            title=request.data.get('title'),
            description=request.data.get('description'),
            dateEvent=request.data.get('dateEvent'),
            startTime=request.data.get('startTime'),
            endTime=request.data.get('endTime'),
            color=request.data.get('color'),
            repeat=request.data.get('repeat'),
            remind=request.data.get('remind'),
        )
        shedule.save()
        return Response(status=status.HTTP_201_CREATED, data={"id": shedule.id})
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def deleting_shedule_api(request):
    if request.method == "POST":
        Shedule.objects.get(id=request.data.get('id')).delete()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)

# ================ For Tracking invetory ======


@api_view(['GET'])
def inventory_track_api(request, *args, **kwargs):
    data = [dx for dx in InventoryTrack.objects.all()
            if dx.shop in get_shop(request)]
    serializer = InventoryTrackSerializer(data, many=True)
    return Response(serializer.data)

# ==================For Profile=============


@api_view(['GET'])
def shop_profile_details(request, *args, **kwargs):
    data = get_shop(request)  # [0]if get_shop(request) else None
    serializer = ShopProfileSerializer(data, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def shop_profile_edit(request):
    if request.method == "POST":
        shop = Shop.objects.get(id=request.data.get('id'))
        shop.name = request.data.get('businessName')
        shop.slogan = request.data.get('businessSlogan')
        shop.instagram_name = request.data.get('instagramName')
        shop.phone = request.data.get('businessPhone')
        shop.email = request.data.get('businessEmail')
        shop.address = request.data.get('businessAddress')
        shop.business_category = request.data.get('businessCategory')
        shop.business_type = request.data.get('businessType')
        shop.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def update_shop_logo(request):
    if request.method == "POST":
        shop = Shop.objects.get(id=int(request.data.get('shopId')))
        shop.logo = request.data.get('file')
        shop.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def update_shop_signature(request):
    if request.method == "POST":
        shop = Shop.objects.get(id=int(request.data.get('shopId')))
        shop.signature = request.data.get('file')
        shop.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


# =============================================

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
            shop=Shop.objects.get(id=request.data.get('shopId')),
            customer_name=request.data.get('customerName'),
            customer_number=request.data.get('phoneNumber'),
            customer_email=request.data.get('emailAddress'),
            customer_address=request.data.get('address'),
        )
        reg.save()
        if request.data.get("openingBalance") > 0:
            reg.customer_payment.create(
                shop=Shop.objects.get(id=request.data.get('shopId')),
                customer=reg,
                is_payment_in=request.data.get("toReceive"),
                description="Opening Balance",
                amount=request.data.get("openingBalance"),
                receipt_no=str(random.randint(1000, 99999)),
            )
        return Response(status=status.HTTP_201_CREATED, data={'customerId': reg.id, 'customerName': reg.customer_name})
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
            shop=Shop.objects.get(id=request.data.get('shopId')),
            customer=data,
            is_payment_in=request.data.get("isPaymentIn"),
            description=request.data.get("description"),
            amount=request.data.get("amount"),
            receipt_no=str(request.data.get('receiptNo')),
        )
        data.save()

        req = Payment.objects.filter(
            shop=Shop.objects.get(id=request.data.get('shopId')),
            customer=data,
            is_payment_in=request.data.get("isPaymentIn"),
            description=request.data.get("description"),
            amount=request.data.get("amount"),
            receipt_no=str(request.data.get('receiptNo')),).first()
        data1 = {
            'customerId': data.id,
            'customerName': data.customer_name,
            'paymentId': req.id
        }
        return Response(status=status.HTTP_201_CREATED, data=data1)
    return Response(status=status.HTTP_400_BAD_REQUEST)


# FOR Invoices


@api_view(['GET', 'POST'])
def all_invoices_api(request):
    data = [dx for dx in Invoice.objects.all() if dx.shop in get_shop(request)]
    serializer = InvoiceSerializer(data, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def edit_invoice_api(request):
    if request.method == "POST":
        # print(request.data)

        invoice = Invoice.objects.get(id=request.data.get('invoiceId'))
        invoice.amount_received = request.data.get('amount_received')
        invoice.total_amount = request.data.get('total_amount')
        invoice.discount = request.data.get('discount')
        try:
            date_due = request.data.get('dueDate').split('-')
            year, month, day = date_due
            invoice.date_due = datetime.datetime(year, month, day),
        except:
            pass

        invoice.invoice_no = str(request.data.get('invoiceNo'))
        invoice.description = request.data.get('description')
        invoice.save()
        # ---- Once Invoice is edited, the initial
        # quantity is returned to inventory and
        # the new ones are taken from inventory

        # # 1st == Deleting the initials items and returning the
        # quantity to the inventory
        for dx in InvoiceSoldItem.objects.all():
            if dx.invoice_data == invoice:
                # Once transaction completed
                # successfully, increasing the
                # quantity of products in the inventory
                try:
                    prod = Product.objects.get(id=dx.product_id)
                    prod.quantity = prod.quantity + dx.quantity
                    prod.save()
                except:
                    pass
                dx.delete()
        # # 2nd  == adding new items to invoice
        # and removing them from the inventory

        for dx in request.data.get('final_items'):
            invoice.sold_items.create(
                shop=Shop.objects.get(id=request.data.get('shopId')),
                product_name=Product.objects.get(
                    id=dx['id']).product_name,
                product_id=dx['id'],
                price=Product.objects.get(
                    id=dx['id']).selling_price_primary,
                product_unit=Product.objects.get(id=dx['id']).primary_unit,
                quantity=dx['quantity'],
                invoice_data=invoice,
            )
            # Once transaction completed
            # successfully, decreasing the quantity of products
            # from the inventory
            prod = Product.objects.get(id=dx['id'])
            prod.quantity = prod.quantity - dx['quantity']
            prod.save()

        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def create_invoice_api(request):
    if request.method == "POST":
        # print(request.data)
        amount_received = request.data.get('amount_received')
        total_amount = request.data.get('total_amount')
        discount = request.data.get('discount')
        customer = request.data.get('customer')
        invoiceNo = request.data.get('invoiceNo')
        items = request.data.get('items')
        description = request.data.get('description')
        reg = Invoice(
            shop=Shop.objects.get(id=request.data.get('shopId')),
            amount_received=amount_received,
            total_amount=total_amount,
            discount=discount,
            date_due=request.data.get('dueDate'),
            invoice_no=str(invoiceNo),
            description=description,
            customer=Customer.objects.get(id=customer)
        )
        # datetime.date.
        reg.save()
        for dx in items:
            reg.sold_items.create(
                shop=Shop.objects.get(id=request.data.get('shopId')),
                product_name=Product.objects.get(id=dx.get('id')).product_name,
                product_id=dx.get('id'),
                price=Product.objects.get(
                    id=dx.get('id')).selling_price_primary,
                purchases_price=Product.objects.get(
                    id=dx.get('id')).purchases_price,
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                invoice_data=reg,
            )
            # Once transaction completed
            # successfully, decreasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity - dx.get('quantity')
            prod.save()
        data = {
            'invoiceId': reg.id,
            'date': reg.created_at,
            "details": [{
                "total_amount": reg.total_amount,
                "due_date": reg.date_due,
                "data": [{
                        "id": i.id,
                        "product": i.product_name,
                        "quantity": i.quantity,
                        "price": i.price,
                        "product_unit": i.product_unit,
                        "product_id": i.product_id,
                        "purchases_price": i.purchases_price,
                        "date": i.updated_at,
                        }
                    for i in reg.sold_items.all()
                ]}],
            "items": [
                {
                    "id": i.id,
                    "productId": i.product_id,
                    "product": i.product_name,
                    "quantity": i.quantity,
                    "price": i.price,
                    "product_unit": i.product_unit,
                    "date": i.updated_at,
                }
                for i in reg.sold_items.all()
            ]
        }
        return Response(status=status.HTTP_201_CREATED, data=data)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def delete_invoice_api(request):
    if request.method == "POST":
        my_id = request.data.get('id')
        # Deleting Invoice means reverse all the
        # activities done in creating the invoice
        invoice = Invoice.objects.get(id=my_id)
        for dx in InvoiceSoldItem.objects.all():
            if dx.invoice_data == invoice:
                # Once transaction completed
                # successfully, increasing the quantity of products
                try:
                    prod = Product.objects.get(id=dx.product_id)
                    prod.quantity = prod.quantity + dx.quantity
                    prod.save()
                except:
                    pass
                dx.delete()
        invoice.delete()
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
            shop=Shop.objects.get(id=request.data.get('shopId')),
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
                shop=Shop.objects.get(id=request.data.get('shopId')),
                product_name=Product.objects.get(id=dx.get('id')).product_name,
                product_id=dx.get('id'),
                price=Product.objects.get(
                    id=dx.get('id')).purchases_price,
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                purchases_data=reg,
            )
            # Once transaction completed
            # successfully, increasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity + dx.get('quantity')
            prod.save()
        data = {
            "id": f"purchases-{reg.id}",
            "date": reg.updated_at,
            "description": reg.description,
            "name": reg.customer.customer_name if reg.customer else 'Purchases',
            "amount": reg.total_amount,  # using total amount instead of paid amount
            "discount": reg.amount_paid - reg.total_amount,  # Balance due

            "details": [{
                "id": i.id,
                "product": i.product_name,
                "quantity": i.quantity,
                "price": i.price,
                "product_unit": i.product_unit,
                "date": i.updated_at,
            } for i in reg.purchased_items.all()]
        }
        return Response(status=status.HTTP_201_CREATED, data=data)
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
            shop=Shop.objects.get(id=request.data.get('shopId')),
            amount=amount,
            bill_no=str(billNo),
            description=description,
            expenses_category=category,
        )
        reg.save()
        if customer:
            reg.customer = Customer.objects.get(id=customer)
            reg.save()
        data = {
            "id":  f"expense-{reg.id}",
            "date": reg.updated_at,
            "name": reg.expenses_category if reg.expenses_category else 'Other indirect expenses',
            "description": reg.description,
            "details": [{
                "id": reg.id,
            }]
        }
        return Response(status=status.HTTP_201_CREATED, data=data)
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
            shop=Shop.objects.get(id=request.data.get('shopId')),
            amount=amount,
            discount=discount,
            # description=description,
            receipt_no=str(request.data.get('receiptNo')),
        )

        reg.save()
        for dx in items:
            reg.sold_items.create(
                shop=Shop.objects.get(id=request.data.get('shopId')),
                product_name=Product.objects.get(id=dx.get('id')).product_name,
                product_id=dx.get('id'),
                price=Product.objects.get(
                    id=dx.get('id')).selling_price_primary,
                purchases_price=Product.objects.get(
                    id=dx.get('id')).purchases_price,
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                cash_sale_data=reg,
            )
            # Once transaction completed
            # successfully, decreasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity - dx.get('quantity')
            prod.save()
        data = {
            "id": f"cash_sale-{reg.id}",
            "date": reg.updated_at,
            "name": "Cash Sales",
            "details": [{
                "id": i.id,
                "product": i.product_name,
                "quantity": i.quantity,
                "price": i.price,
                "product_unit": i.product_unit,
                "product_id": i.product_id,
                "purchases_price": i.purchases_price,
                "date": i.updated_at,
            } for i in reg.sold_items.all()]
        }
        return Response(status=status.HTTP_201_CREATED, data=data)
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
            shop=Shop.objects.get(id=request.data.get('shopId')),
            amount=amount,
            discount=discount,
            description=description,
            customer=Customer.objects.get(id=customer),
            receipt_no=str(request.data.get('receiptNo')),
        )
        reg.save()

        for dx in items:
            reg.sold_items.create(
                shop=Shop.objects.get(id=request.data.get('shopId')),
                product_name=Product.objects.get(id=dx.get('id')).product_name,
                product_id=dx.get('id'),
                price=Product.objects.get(
                    id=dx.get('id')).selling_price_primary,
                purchases_price=Product.objects.get(
                    id=dx.get('id')).purchases_price,
                product_unit=Product.objects.get(id=dx.get('id')).primary_unit,
                quantity=dx.get('quantity'),
                cash_sale_customer=reg,
            )
            # Once transaction completed
            # successfully, decreasing the quantity of products
            prod = Product.objects.get(id=dx.get('id'))
            prod.quantity = prod.quantity - dx.get('quantity')
            prod.save()
        data = {
            "id": f"cash_sale_customer-{reg.id}",
            "date": reg.updated_at,
            "name": reg.customer.customer_name,
            "details": [{
                "id": i.id,
                "product": i.product_name,
                "quantity": i.quantity,
                "price": i.price,
                "product_unit": i.product_unit,
                "product_id": i.product_id,
                "purchases_price": i.purchases_price,
                "date": i.updated_at,
            } for i in reg.sold_items.all()]
        }
        return Response(status=status.HTTP_201_CREATED, data=data)
    return Response(status=status.HTTP_400_BAD_REQUEST)

# For products


@api_view(['POST'])
def update_product_thumbnail(request, product):
    if request.method == "POST":
        product = Product.objects.get(id=product)
        product.product_image = request.data.get('file')
        product.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def add_new_product_api(request):
    if request.method == "POST":
        product = Product(
            shop=Shop.objects.get(id=request.data.get('shopId')),
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
        # Track new product when added
        InventoryTrack(
            shop=Shop.objects.get(id=request.data.get('shopId')),
            product_id=product.id,
            product_name=product.product_name,
            quantity_added=product.quantity,
            purchases_price=product.purchases_price,
        ).save()
        return Response(status=status.HTTP_201_CREATED, data={'productId': product.id})
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
        product.quantity += request.data.get('quantity')
        product.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_400_BAD_REQUEST)

# ========= Version check


@api_view(['GET'])
@permission_classes([AllowAny])
def version_check(request, *args, **kwargs):
    data = VersionTrack.objects.all().latest('id')
    return Response(data={'version': data.current_version})
