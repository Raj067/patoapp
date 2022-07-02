from rest_framework import serializers
from home.models import *
from rest_framework.validators import UniqueTogetherValidator
from accounts.models import CustomUser



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
        fields = ('id', 'name', 'slogan',)


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ('id', 'product_name', 'purchases_price',)


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

    class Meta:
        model = Customer
        fields = ('id', 'customer_name', 'customer_number',
                  'customer_payment', 'customer_invoice', 'customer_purchase')
