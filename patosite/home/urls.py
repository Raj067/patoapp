
from django.urls import path, include
from .views import *

home_urls = [
    path('', home_page, name="home_page"),
    path('demo/', demo_page, name="demo_page"),
    path('about/', about_page, name="about_page"),
    path('blog/', blog_page, name="blog_page"),
    path('contact/', contact_page, name="contact_page"),
]
