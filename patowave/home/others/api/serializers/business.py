from home.models import *


def general_business_data(request, shop):
    # data should be return as int -- > rounded
    data = {
        "sales_week": 1000, "expenses_week": 8900,
        "sales_month": 1000, "expenses_month": 8900,
        "profit_month": 1000, "profit_week": 8900,
    }
    return data


def business_financial_data(request, shop):
    data = []
    for dx in Payment.objects.all():
        if dx.shop in shop:
            data.append({
                "date": dx.updated_at,
                "description": dx.description,
                "name": dx.customer.customer_name,
                "amount": dx.amount,
                "discount": 0,
                "isCashSale": False,
                "isExpenses": False,
                "isPaymentIn": True if dx.is_payment_in else False,
                "isPaymentOut": False if dx.is_payment_in else True,
                "isInvoice": False,
                "isPurchases": False,
                "receipt": dx.receipt_no,
                "details": [{
                    "id": dx.customer.id,
                    "customer_name": dx.customer.customer_name,
                }]
            })
    for dx in Expense.objects.all():
        if dx.shop in shop:
            data.append({
                "date": dx.updated_at,
                "description": dx.description,
                "name": "Expenses",
                "amount": dx.amount,
                "discount": 0,
                "isCashSale": False,
                "isExpenses": True,
                "isPaymentIn": False,
                "isPaymentOut": False,
                "isInvoice": False,
                "isPurchases": False,
                "receipt": dx.bill_no,
                "details": [{
                        "id": dx.id,
                }]
            })

    for dx in Purchase.objects.all():
        if dx.shop in shop:
            data.append({
                "date": dx.updated_at,
                "description": dx.description,
                "name": dx.customer.customer_name,
                "amount": dx.amount,
                "discount": 0,
                "isCashSale": False,
                "isExpenses": False,
                "isPaymentIn": False,
                "isPaymentOut": False,
                "isInvoice": False,
                "isPurchases": True,
                "receipt": dx.bill_no,
                "details": [{
                        "id": i.id,
                        "product": i.product.product_name,
                        "quantity": i.quantity,
                        "price": i.price,
                        "product_unit": i.product_unit,
                        "date": i.updated_at,
                        }
                    for i in dx.purchased_items.all()
                ]
            })

    # for dx in Invoice.objects.all():
    #     if dx.shop in shop:
    #         data.append([dx.updated_at, 0, dx.amount])
    for dx in CashSale.objects.all():
        if dx.shop in shop:
            data.append({
                "date": dx.updated_at,
                "description": "Cash Sales",
                "name": "Cash Sales",
                "amount": dx.amount,
                "discount": dx.discount,
                "isCashSale": True,
                "isExpenses": False,
                "isPaymentIn": False,
                "isPaymentOut": False,
                "isInvoice": False,
                "isPurchases": False,
                "receipt": dx.receipt_no,
                "details": [{
                    "id": i.id,
                    "product": i.product.product_name,
                    "quantity": i.quantity,
                    "price": i.price,
                    "product_unit": i.product_unit,
                    "date": i.updated_at,
                } for i in dx.sold_items.all()]
            })
    return data
