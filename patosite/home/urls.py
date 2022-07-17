
from django.urls import path, include
from .views import *

home_urls = [
    path('', home_page, name="home_page"),
]
