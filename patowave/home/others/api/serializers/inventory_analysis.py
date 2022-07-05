from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import Product


class TopSellingProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ('id', 'amount', 'is_payment_in',)


class InventoryAnalysisSerializer(serializers.ModelSerializer):
    instock = SerializerMethodField()
    stockin = SerializerMethodField()
    stock_out = SerializerMethodField()
    inventory_turnover = SerializerMethodField()

    class Meta:
        model = Product
        fields = (
            'instock', 'stockin', 'stock_out',
            'inventory_turnover',
        )

    def get_instock(mySerializer, myModel):
        return 100

    def get_stockin(mySerializer, myModel):
        return 100

    def get_stock_out(mySerializer, myModel):
        return 100

    def get_inventory_turnover(mySerializer, myModel):
        return 100
