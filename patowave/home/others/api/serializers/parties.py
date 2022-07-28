from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import Customer
from home.others.api.functions.func import format_date


def general_parties_data(request, shop):
    # print(request.user.is_authenticated, shop)
    # data should be return as int -- > rounded
    data = {
        "total_debt_week": 1000, "total_customer_debt_week": 8900,
        "total_debt_month": 1000, "total_customer_debt_month": 8900,
    }
    return data


class CustomerSerializer(serializers.ModelSerializer):
    effective_amount = SerializerMethodField()
    financial_data = SerializerMethodField()
    shopId = SerializerMethodField()

    class Meta:
        model = Customer
        fields = ('id', 'customer_name', 'customer_number', 'customer_address',
                  'customer_email', 'effective_amount', 'financial_data', 'shopId')

    def get_shopId(mySerializer, myModel):
        return myModel.shop.id

    def get_effective_amount(mySerializer, myModel):
        val = 0
        # For all payments
        for dx in myModel.customer_payment.all():
            if dx.is_payment_in:
                val += dx.amount
            else:
                val -= dx.amount

        # For all purchases
        for dx in myModel.customer_purchase.all():
            val -= dx.amount

        # For all Invoices
        for dx in myModel.customer_invoice.all():
            val -= dx.amount
        return val

    def get_financial_data(mySerializer, myModel):
        data = []
        # For all payments
        for dx in myModel.customer_payment.all():
            if dx.is_payment_in:
                data.append({
                    "name": "Payment in", "description": dx.description if dx.description else "Payment in",
                    "received": dx.amount, "paid": 0, "date": format_date(dx.created_at)
                })
            else:
                data.append({
                    "name": "Payment out", "description": dx.description if dx.description else "Payment out",
                    "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
                })

        # For all purchases
        for dx in myModel.customer_purchase.all():
            data.append({
                "name": "name", "description": "description",
                "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
            })

        # # For all Invoices
        # for dx in myModel.customer_invoice.all():
        #     data.append({
        #         "name": "Invoice", "description": "description",
        #         "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
        #     })
        return data
