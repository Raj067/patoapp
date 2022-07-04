from rest_framework import serializers
from home.models import *
from rest_framework.validators import UniqueTogetherValidator
from accounts.models import CustomUser
from rest_framework.fields import SerializerMethodField
from calendar import month_name


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = CustomUser.objects.create_user(**validated_data)
        return user

    class Meta:
        model = CustomUser
        fields = (
            'username',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=CustomUser.objects.all(),
                fields=['username', ]
            )
        ]


class ShopProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = (
            'id', 'name', 'slogan',
            'phone', 'email', 'logo',
            'signature', 'address', 'media_link',
        )


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = (
            'id', 'product_name', 'purchases_price',
            'product_code', 'selling_price_primary',
            'selling_price_secondary', 'quantity', 'stock_level',
            'primary_unit', 'secondary_unit', 'rate_unit',
            'supplier_name', 'supplier_number', 'supplier_email',
            'created_at', 'product_image',
        )


class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = ('id', 'amount', 'is_payment_in',)


class InvoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Invoice
        fields = ('id', 'amount', 'is_payment_in',)


class PurchaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Purchase
        fields = ('id', 'amount', 'is_payment_in',)


class CustomerSerializer(serializers.ModelSerializer):
    # customer_payment = PaymentSerializer(many=True, read_only=True)
    # customer_invoice = PaymentSerializer(many=True, read_only=True)
    # customer_purchase = PaymentSerializer(many=True, read_only=True)
    effective_amount = SerializerMethodField()
    financial_data = SerializerMethodField()

    class Meta:
        model = Customer
        fields = ('id', 'customer_name', 'customer_number',
                  'effective_amount', 'financial_data')

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
                    "name": "Payment in", "description": dx.description,
                    "received": dx.amount, "paid": 0, "date": format_date(dx.created_at)
                })
            else:
                data.append({
                    "name": "Payment out", "description": dx.description,
                    "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
                })

        # For all purchases
        for dx in myModel.customer_purchase.all():
            data.append({
                "name": "name", "description": "description",
                "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
            })

        # For all Invoices
        for dx in myModel.customer_invoice.all():
            data.append({
                "name": "Invoice", "description": "description",
                "received": 0, "paid": dx.amount, "date": format_date(dx.created_at)
            })
        return data


def format_date(date):
    return f"{date.day} {month_name[date.month]}, {date.year} "
