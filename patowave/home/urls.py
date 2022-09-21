from django.urls import path, include
from .views import *

urlpatterns = [
    path('privacy-policy/', privacy_policy, name="privacy_policy"),
    path('terms-conditions/', terms_conditions, name="terms"),
    path('forgot-password/', forgot_password, name="forgot_password"),
    path('tutorials/', tutorials, name="tutorials"),
    #
    path('', home_page, name="home_page"),
    path('demo/', demo_page, name="demo_page"),
    path('about/', about_page, name="about_page"),
    path('blog/', blog_page, name="blog_page"),
    path('contact/', contact_page, name="contact_page"),
]
