from django.urls import path, include
from .views import *

api_urls = [
    #     # Shop api
    path('api/main-shop-details/', main_shop_details, name='main_shop_details'),
    path('api/inventory-products/',
         inventory_pruducts_api, name='inventory_pruducts_api'),
    path('api/parties-details/',
         parties_details_api, name='parties_details_api'),
    #     path('api/edit-existing-shop/<int:shop_id>/', parties_details_api
    #          edit_existing_shop, name='edit_existing_shop'),
    #     path('api/delete-existing-shop/<int:shop_id>/',
    #          delete_existing_shop, name='delete_existing_shop'),

    #     # Product api
    #     path('api/all-shop-products/', all_shop_products, name='all_shop_products'),
    #     path('api/single-shop-product/<int:product_id>/', single_shop_product,
    #          name='single_shop_product'),

    #     # Custoomer api
    #     path('api/all-shop-customers/', all_shop_customers, name='all_shop_customers')

]
