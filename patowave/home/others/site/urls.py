from django.urls import path, include
from .views import *

urlpatterns = [
    path('home/', home, name='home'),
    path('blog/', blog, name='blog'),
    path('blog/<slug:slug>/', single_blog, name='single_blog'),
    path('tutorial/', tutorial, name='tutorial'),
    path('tutorial/<slug:slug>/', single_tutorial, name='single_tutorial'),
    path('faqs/', faqs, name='faqs'),
    path('contact-us/', contact, name='contact'),
    path('about-us/', about, name='about'),
    path('terms-conditions/', terms, name='terms'),
    path('privacy-policy/', policies, name='policies'),
]
