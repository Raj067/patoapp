from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import Product

class ProductSerializer(serializers.ModelSerializer):
    shopId = SerializerMethodField()
    class Meta:
        model = Product
        fields = (
            'id', 'product_name', 'purchases_price',
            'product_code', 'selling_price_primary',
            'selling_price_secondary', 'quantity', 'stock_level',
            'primary_unit', 'secondary_unit', 'rate_unit',
            'supplier_name', 'supplier_number', 'supplier_email',
            'created_at', 'product_image', 'is_service' , 'shopId'
        )

    def get_shopId(mySerializer, myModel):
        return myModel.shop.id
