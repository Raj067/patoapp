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
    # setting_account_api
    path('api/signup-user/', signup_user, name='signup_user'),

    #  PROFILE update_shop_logo
    path('api/setting-account/', setting_account_api,
         name='setting_account_api'),
    path('api/shop-profile-details/',
         shop_profile_details, name='shop_profile_details'),
    path('api/shop-profile-edit/', shop_profile_edit,
         name='shop_profile_edit'),
    path('api/update-shop-logo/', update_shop_logo,
         name='update_shop_logo'),
    path('api/update-shop-signature/', update_shop_signature,
         name='update_shop_signature'),
    #
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
    path('api/deleting-single-transaction/', deleting_single_transaction_api,
         name='deleting_single_transaction_api'),

    # TRANSACTIONS
    path('api/cash-sales-transaction/', cash_sales_transaction_api,
         name='cash_sales_transaction_api'),
    path('api/cash-sales-customer-transaction/', cash_sales_customer_transaction_api,
         name='cash_sales_customer_transaction_api'),
    #     purchases_transaction_api expenses_transaction_api
    path('api/purchases-transaction/', purchases_transaction_api,
         name='purchases_transaction_api'),
    path('api/expenses-transaction/', expenses_transaction_api,
         name='expenses_transaction_api'),

    # Product adjust_product_api
    path('api/add-new-product/', add_new_product_api,
         name='add_new_product_api'),
    path('api/edit-product/', edit_product_api,
         name='edit_product_api'),
    path('api/delete-product/', delete_product_api,
         name='delete_product_api'),
    path('api/adjust-product/', adjust_product_api,
         name='adjust_product_api'),

    # Invoice
    path('api/create-invoice/', create_invoice_api,
         name='create_invoice_api'),
    path('api/all-invoices/', all_invoices_api,
         name='all_invoices_api'),

    # Shedule 
    path('api/shedule-details/', shedule_details,
         name='shedule_details'),
    path('api/add-shedule/', add_shedule,
         name='add_shedule'),
]
