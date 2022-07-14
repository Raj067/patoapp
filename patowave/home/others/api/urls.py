from django.urls import path, include
from .views import *
from rest_framework.authtoken import views

# top_selling_items greeting_cards
api_urls = [
    path('api/greeting-cards/', greeting_cards,
         name='greeting_cards'),
    path('api/top-selling-items/', top_selling_items,
         name='top_selling_items'),
    path('api/general-parties-details/', general_parties_details,
         name='general_parties_details'),

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
    # CUSTOMERS
    path('api/add-new-customer/',
         add_new_customer_api, name='add_new_customer_api'),
    path('api/edit-existing-customer/',
         edit_existing_customer_api, name='edit_existing_customer_api'),
    path('api/adding-payment-customer/',
         adding_payment_customer_api, name='adding_payment_customer_api'),

    # BUSINESS deleting_single_transaction_api
    path('api/general-business-details/', general_business_details,
         name='general_business_data'),
    path('api/business-financial-transactions/', business_financial_transactions,
         name='business_financial_transactions'),
    path('api/financial-header/', financial_header,
         name='financial_header'),
    path('api/deleting-single-transaction/', deleting_single_transaction_api,
         name='deleting_single_transaction_api'),

    # TRANSACTIONS
    path('api/cash-sales-transaction/', cash_sales_transaction_api,
         name='cash_sales_transaction_api'),
]
