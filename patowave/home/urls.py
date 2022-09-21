from django.urls import path, include
from .views import *

urlpatterns = [
    path('privacy-policy/', privacy_policy, name="privacy_policy"),
    path('terms-conditions/', terms_conditions, name="terms"),
    path('forgot-password/', forgot_password, name="forgot_password"),
    path('tutorials/', tutorials, name="tutorials"),
]
