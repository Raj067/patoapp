from .others.dashboard.urls import dashboard_urls
from .others.api.urls import api_urls
from .others.web.urls import web_urls

from django.urls import path, include
from .views import *

home_urls = [
    path('privacy-policy/', privacy_policy, name="privacy_policy"),
    path('terms-conditions/', terms_conditions, name="terms"),
    path('forgot-password/', forgot_password, name="forgot_password"),
    path('tutorials/', tutorials, name="tutorials"),
]

home_urls += dashboard_urls + api_urls + web_urls
