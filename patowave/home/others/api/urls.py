from django.urls import path, include
from .views import *
from rest_framework.authtoken import views

# top_selling_items
api_urls = [
    path('api/top-selling-items/', top_selling_items,
         name='top_selling_items'),
    path('api/general-parties-details/', general_parties_details,
         name='general_parties_details'),
    path('api/general-business-details/', general_business_details,
         name='general_business_data'),
    path('api/general-inventory-analysis/', general_inventory_analysis,
         name='general_inventory_analysis'),
    
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
    #     # Shop api
    path('api/shop-profile-details/',
         shop_profile_details, name='shop_profile_details'),
    path('api/inventory-products/',
         inventory_pruducts_api, name='inventory_pruducts_api'),
    path('api/parties-details/',
         parties_details_api, name='parties_details_api'),

]
