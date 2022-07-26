from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import Shop


class ShopProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = (
            'id', 'name', 'slogan',
            'phone', 'email', 'logo',
            'signature', 'address', 'instagram_name',
            'business_category', 'business_type',
        )
