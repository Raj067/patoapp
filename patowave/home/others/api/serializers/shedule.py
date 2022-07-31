from rest_framework import serializers
from rest_framework.fields import SerializerMethodField
from home.models import Shedule


class SheduleProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shedule
        fields = (
            'id', 'title', 'description',
            'dateEvent', 'startTime', 'endTime',
            'color', 'repeat', 'remind',
        )
