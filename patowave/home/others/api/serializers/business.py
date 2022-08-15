from home.models import *


def business_financial_data(request, shop):
    data = []
    for dx in Payment.objects.all():
        if dx.shop in shop:
            data.append({
                "id": f"payment-{dx.id}",
                "shopId": dx.shop.id,
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
                "id": f"expense-{dx.id}",
                "shopId": dx.shop.id,
                "date": dx.updated_at,
                "description": dx.description,
                "name": dx.expenses_category if dx.expenses_category else 'Other indirect expenses',
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
                "id": f"purchases-{dx.id}",
                "shopId": dx.shop.id,
                "date": dx.updated_at,
                "description": dx.description,
                "name": dx.customer.customer_name if dx.customer else 'Purchases',
                # "amount": dx.amount_paid,
                "amount": dx.total_amount,  # using total amount instead of paid amount
                "discount": dx.amount_paid - dx.total_amount,  # Balance due
                "isCashSale": False,
                "isExpenses": False,
                "isPaymentIn": False,
                "isPaymentOut": False,
                "isInvoice": False,
                "isPurchases": True,
                "receipt": dx.bill_no,
                "details": [{
                        "id": i.id,
                        "product": i.product_name,
                        "quantity": i.quantity,
                        "price": i.price,
                        "product_unit": i.product_unit,
                        "date": i.updated_at,
                        }
                    for i in dx.purchased_items.all()
                ]
            })

    for dx in Invoice.objects.all():
        if dx.shop in shop:
            data.append({
                "id": f"invoice-{dx.id}",
                "shopId": dx.shop.id,
                "date": dx.updated_at,
                "description": dx.description,
                "name": dx.customer.customer_name,
                "amount": dx.amount_received,
                "discount": 0,
                "isCashSale": False,
                "isExpenses": False,
                "isPaymentIn": False,
                "isPaymentOut": False,
                "isInvoice": True,
                "isPurchases": False,
                "receipt": dx.invoice_no,
                "details": [{
                    "total_amount": dx.total_amount,
                    "due_date": dx.date_due,
                    "data": [{
                        "id": i.id,
                        "product": i.product_name,
                        "quantity": i.quantity,
                        "price": i.price,
                        "product_unit": i.product_unit,
                        "date": i.updated_at,
                    }
                        for i in dx.sold_items.all()
                    ]}]
            })

    for dx in CashSale.objects.all():
        if dx.shop in shop:
            data.append({
                "id": f"cash_sale-{dx.id}",
                "shopId": dx.shop.id,
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
                    "product": i.product_name,
                    "quantity": i.quantity,
                    "price": i.price,
                    "product_unit": i.product_unit,
                    "date": i.updated_at,
                } for i in dx.sold_items.all()]
            })
    for dx in CashSaleCustomer.objects.all():
        if dx.shop in shop:
            data.append({
                "id": f"cash_sale_customer-{dx.id}",
                "shopId": dx.shop.id,
                "date": dx.updated_at,
                "description": "Cash Sales",
                "name": dx.customer.customer_name,
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
                    "product": i.product_name,
                    "quantity": i.quantity,
                    "price": i.price,
                    "product_unit": i.product_unit,
                    "date": i.updated_at,
                } for i in dx.sold_items.all()]
            })
    data = sorted(data, key=lambda item: item.get('date'), reverse=True)
    return data
