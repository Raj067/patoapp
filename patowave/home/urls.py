from .others.dashboard.urls import dashboard_urls
from .others.api.urls import api_urls
from .others.web.urls import web_urls

from django.urls import path, include
from .views import *

home_urls = [
]

home_urls += dashboard_urls + api_urls + web_urls
