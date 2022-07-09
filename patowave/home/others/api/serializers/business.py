from home.others.api.functions.func import format_date
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
                "isCashSale": False,
                "isExpenses": False,
                "isPaymentIn": True if dx.is_payment_in else False,
                "isPaymentOut": False if dx.is_payment_in else True,
                "isInvoice": False,
                "isPurchases": False,
                "details": [{
                    "id": dx.customer.id,
                    "customer_name": dx.customer.customer_name,
                }]
            })
    # for dx in Expense.objects.all():
    #     if dx.shop in shop:
    #         data.append([dx.updated_at, 0, dx.amount])
    # for dx in Purchase.objects.all():
    #     if dx.shop in shop:
    #         data.append([dx.updated_at, 0, dx.amount])
    # for dx in Invoice.objects.all():
    #     if dx.shop in shop:
    #         data.append([dx.updated_at, 0, dx.amount])
    # for dx in CashSale.objects.all():
    #     if dx.shop in shop:
    #         data.append([dx.updated_at, dx.amount, 0])

    return data


def financial_header_data(request, shop):
    data = []
    for dx in Payment.objects.all():
        if dx.shop in shop:
            data.append({
                "date": dx.updated_at,
                "income":  dx.amount if dx.is_payment_in else 0,
                "expenses":  0 if dx.is_payment_in else dx.amount,
            })
#     for dx in Expense.objects.all():
#         if dx.shop in shop:
#             data.append([dx.updated_at, 0, dx.amount])
#     for dx in Purchase.objects.all():
#         if dx.shop in shop:
#             data.append([dx.updated_at, 0, dx.amount])
#     for dx in Invoice.objects.all():
#         if dx.shop in shop:
#             data.append([dx.updated_at, 0, dx.amount])
#     for dx in CashSale.objects.all():
#         if dx.shop in shop:
#             data.append([dx.updated_at, dx.amount, 0])

    # Removing duplicates in dates
    _data = []
    for i in data:
        if i.get("date").date() not in [j.get("date").date() for j in _data]:
            _data.append(i)
    return _data
