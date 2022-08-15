from rest_framework import serializers
from home.models import *

from .serializers.inventory import *
from .serializers.inventory_analysis import *
from .serializers.parties import *
from .serializers.profile import *
from .serializers.business import *
from .serializers.greeting_cards import *
from .serializers.shedule import *


class InvoiceSerializer(serializers.ModelSerializer):
    shopId = SerializerMethodField()
    customer_data = SerializerMethodField()
    items = SerializerMethodField()
    fullName = SerializerMethodField()

    class Meta:
        model = Invoice
        fields = ('id', 'shopId', 'amount_received',
                  'date_due', 'total_amount', 'discount',
                  'description', 'customer_data', 'items',
                  'fullName', 'invoice_no',
                  )

    def get_shopId(mySerializer, myModel):
        return myModel.shop.id

    def get_customer_data(mySerializer, myModel):
        return myModel.customer.id

    def get_fullName(mySerializer, myModel):
        return myModel.customer.customer_name

    def get_items(mySerializer, myModel):
        data = [
            {
                "id": i.id,
                "productId":i.product_id,
                "product": i.product_name,
                "quantity": i.quantity,
                "price": i.price,
                "product_unit": i.product_unit,
                "date": i.updated_at,
            }
            for i in myModel.sold_items.all()
        ]
        return data
