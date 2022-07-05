from rest_framework import serializers
from home.models import *
from rest_framework.validators import UniqueTogetherValidator
from accounts.models import CustomUser
from rest_framework.fields import SerializerMethodField

from .serializers.inventory import *
from .serializers.inventory_analysis import *
from .serializers.parties import *
from .serializers.profile import *
from .serializers.business import *


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
