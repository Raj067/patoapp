from django.urls import path, include
from .views import *

urlpatterns = [
    path('home/', home, name='home'),
    path('blog/', blog, name='blog'),
    path('blog/<slug:slug>/', single_blog, name='single_blog'),
]
