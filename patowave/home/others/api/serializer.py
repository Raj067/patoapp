from rest_framework import serializers
from home.models import *

from .serializers.inventory import *
from .serializers.inventory_analysis import *
from .serializers.parties import *
from .serializers.profile import *
from .serializers.business import *
from .serializers.greeting_cards import *

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
