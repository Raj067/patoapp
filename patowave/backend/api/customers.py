from django.http import JsonResponse
from home.models import *


def all_shop_customers_der(request, shop):
    customer = list()
    total_sales = list()
    total_expenses = list()
    total_transaction = list()

    for dx in Customer.objects.all():
        if dx.shop == shop:
            customer.append(dx)
            sale = [i for i in Sale.objects.all() if i.shop ==
                    shop and i.customer == dx]
            expense = [i for i in Expense.objects.all() if i.shop ==
                       shop and i.customer == dx]
            print(sale, expense)
    data = {'response': [
        {'customer_name': i.customer_name, 'customer_number': i.customer_number,
         'customer_email': i.customer_email, 'opening_balance': i.opening_balance}
        for i in customer],
        'status': 404
    }
    return JsonResponse(data=data, safe=False)
