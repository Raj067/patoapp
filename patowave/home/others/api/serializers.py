from rest_framework import serializers

from home.models import Shop


class MainShopDetailsSerializer(serializers.ModelSerializer):

    class Meta:
        model = Shop
        fields = ('id', 'name', 'slogan',)
