from rest_framework import serializers
from home.models import *

from .serializers.inventory import *
from .serializers.inventory_analysis import *
from .serializers.parties import *
from .serializers.profile import *
from .serializers.business import *
from .serializers.greeting_cards import *


class InvoiceSerializer(serializers.ModelSerializer):
    shopId = SerializerMethodField()
    customer_data = SerializerMethodField()
    items = SerializerMethodField()

    class Meta:
        model = Invoice
        fields = ('id', 'shopId', 'amount_received',
                  'due_date', 'total_amount', 'discount',
                  'description', 'customer_data', 'items',
                  )

    def get_shopId(mySerializer, myModel):
        return myModel.shop.id

    def get_customer_data(mySerializer, myModel):
        return myModel.customer.id

    def get_items(mySerializer, myModel):
        data = [
            {
                "id": i.id,
                "product": i.product.product_name,
                "quantity": i.quantity,
                "price": i.price,
                "product_unit": i.product_unit,
                "date": i.updated_at,
            }
            for i in myModel.sold_items.all()
        ]
        return data
