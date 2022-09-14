from django.urls import path, include
from .views import *

dashboard_urls = [
    path('dashboard/', dashboard, name='dashboard'),
]
