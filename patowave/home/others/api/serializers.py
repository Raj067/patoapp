from rest_framework import serializers
from home.models import *
from rest_framework.validators import UniqueTogetherValidator
from accounts.models import CustomUser
from rest_framework.fields import SerializerMethodField


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
    customer_payment = PaymentSerializer(many=True, read_only=True)
    customer_invoice = PaymentSerializer(many=True, read_only=True)
    customer_purchase = PaymentSerializer(many=True, read_only=True)
    effective_amount = SerializerMethodField()

    class Meta:
        model = Customer
        fields = ('id', 'customer_name', 'customer_number',
                  'customer_payment', 'customer_invoice', 'customer_purchase', 'effective_amount',)

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
        for dx in myModel.customer_payment.all():
            val -= dx.amount
        return val
