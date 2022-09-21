from django.urls import path, include
from .views import *
from rest_framework.authtoken import views

# top_selling_items greeting_cards
urlpatterns = [
    path('greeting-cards/', greeting_cards,
         name='greeting_cards'),
    path('top-selling-items/', top_selling_items,
         name='top_selling_items'),

    path('general-inventory-analysis/', general_inventory_analysis,
         name='general_inventory_analysis'),

    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
    #     # Shop api
    # setting_account_api
    path('signup-user/', signup_user, name='signup_user'),

    #  PROFILE update_shop_logo
    path('setting-account/', setting_account_api,
         name='setting_account_api'),
    path('shop-profile-details/',
         shop_profile_details, name='shop_profile_details'),
    path('shop-profile-edit/', shop_profile_edit,
         name='shop_profile_edit'),
    path('update-shop-logo/', update_shop_logo,
         name='update_shop_logo'),
    path('update-shop-signature/', update_shop_signature,
         name='update_shop_signature'),
    #
    path('inventory-products/',
         inventory_pruducts_api, name='inventory_pruducts_api'),
    path('parties-details/',
         parties_details_api, name='parties_details_api'),
    # CUSTOMERS
    path('add-new-customer/',
         add_new_customer_api, name='add_new_customer_api'),
    path('edit-existing-customer/',
         edit_existing_customer_api, name='edit_existing_customer_api'),
    path('adding-payment-customer/',
         adding_payment_customer_api, name='adding_payment_customer_api'),

    # BUSINESS deleting_single_transaction_api
    path('business-financial-transactions/', business_financial_transactions,
         name='business_financial_transactions'),
    path('deleting-single-transaction/', deleting_single_transaction_api,
         name='deleting_single_transaction_api'),

    # TRANSACTIONS
    path('cash-sales-transaction/', cash_sales_transaction_api,
         name='cash_sales_transaction_api'),
    path('cash-sales-customer-transaction/', cash_sales_customer_transaction_api,
         name='cash_sales_customer_transaction_api'),
    #     purchases_transaction_api expenses_transaction_api
    path('purchases-transaction/', purchases_transaction_api,
         name='purchases_transaction_api'),
    path('expenses-transaction/', expenses_transaction_api,
         name='expenses_transaction_api'),

    # Product
    path('add-new-product/', add_new_product_api,
         name='add_new_product_api'),
    path('edit-product/', edit_product_api,
         name='edit_product_api'),
    path('delete-product/', delete_product_api,
         name='delete_product_api'),
    path('adjust-product/', adjust_product_api,
         name='adjust_product_api'),
    path('update-product-thumbnail/<int:product>/', update_product_thumbnail,
         name='update_product_thumbnail'),

    # Invoice
    path('create-invoice/', create_invoice_api,
         name='create_invoice_api'),
    path('all-invoices/', all_invoices_api,
         name='all_invoices_api'),
    path('delete-invoices/', delete_invoice_api,
         name='delete_invoice_api'),
    path('edit-invoice/', edit_invoice_api,
         name='edit_invoice_api'),

    # Shedule
    path('shedule-details/', shedule_details,
         name='shedule_details'),
    path('add-shedule/', add_shedule,
         name='add_shedule'),
    path('deleting-shedule/', deleting_shedule_api,
         name='deleting_shedule_api'),

    # for tracking inventory inventory_track_api
    path('inventory-track/', inventory_track_api,
         name='inventory_track_api'),

    # for version tracking
    path('version-check/', version_check, name='version_check'),

    # Feedback receive_feedback
    path('receive-feedback/', receive_feedback, name='receive_feedback'),

]
