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


# def financial_header_data(request, shop):
#     data = []
#     # date, income, expenses
#     for dx in Payment.objects.all():
#         if dx.shop in shop:
#             if dx.is_payment_in:
#                 data.append([dx.updated_at, dx.amount, 0])
#             else:
#                 data.append([dx.updated_at, 0, dx.amount])
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

#     return data
