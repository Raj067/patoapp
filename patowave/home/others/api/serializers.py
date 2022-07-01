from rest_framework import serializers
from home.models import *


class MainShopDetailsSerializer(serializers.ModelSerializer):

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


class CustomerSerializer(serializers.ModelSerializer):
    customer_payment = PaymentSerializer(many=True, read_only=True)
 
    class Meta:
        model = Customer
        fields = ('id', 'customer_name', 'customer_number', 'customer_payment')
