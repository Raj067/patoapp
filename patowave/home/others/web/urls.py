from django.urls import path, include
from .views import *

web_urls = [
    path('', dashboard, name='dashboard'),
]
