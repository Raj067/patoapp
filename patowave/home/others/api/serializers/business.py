from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import Customer
from home.others.api.functions.func import format_date


def general_business_data(request, shop):
    # data should be return as int -- > rounded
    data = {
        "sales_week": 1000, "expenses_week": 8900,
        "sales_month": 1000, "expenses_month": 8900,
        "profit_month": 1000, "profit_week": 8900,
    }
    return data

# class CustomerSerializer(serializers.ModelSerializer):
#     # customer_payment = PaymentSerializer(many=True, read_only=True)
#     # customer_invoice = PaymentSerializer(many=True, read_only=True)
#     # customer_purchase = PaymentSerializer(many=True, read_only=True)
#     effective_amount = SerializerMethodField()
#     financial_data = SerializerMethodField()

#     class Meta:
#         model = Customer
#         fields = ('id', 'customer_name', 'customer_number',
#                   'effective_amount', 'financial_data')

#     def get_effective_amount(mySerializer, myModel):
#         val = 0
#         # For all payments
#         for dx in myModel.customer_payment.all():
#             if dx.is_payment_in:
#                 val += dx.amount
#             else:
#                 val -= dx.amount

#         # For all purchases
#         for dx in myModel.customer_purchase.all():
#             val -= dx.amount

#         # For all Invoices
#         for dx in myModel.customer_invoice.all():
#             val -= dx.amount
#         return val

#     def get_financial_data(mySerializer, myModel):
#         data = []
#         # For all payments
#         for dx in myModel.customer_payment.all():
#             if dx.is_payment_in:
#                 data.append({
#                     "name": "Payment in", "description": dx.description if dx.description else "Payment in",
#                     "received": dx.amount, "paid": 0, "date": format_date(dx.created_at)
#                 })
#             else:
#                 data.append({
#                     "name": "Payment out", "description": dx.description if dx.description else "Payment out",
#                     "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
#                 })

#         # For all purchases
#         for dx in myModel.customer_purchase.all():
#             data.append({
#                 "name": "name", "description": "description",
#                 "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
#             })

#         # For all Invoices
#         for dx in myModel.customer_invoice.all():
#             data.append({
#                 "name": "Invoice", "description": "description",
#                 "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
#             })
#         return data
