from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import GreetingCard


class GreetingCardSerializer(serializers.ModelSerializer):
    class Meta:
        model = GreetingCard
        fields = (
            'id', 'card_category', 'default_text',
            'greeting_card',
        )
