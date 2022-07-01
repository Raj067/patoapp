from django.contrib import admin
from .models import *

# Register your models here.


class ShopAdmin(admin.ModelAdmin):
    list_display = ['name', 'email', 'slogan', 'created_at']


class ShopUserAdmin(admin.ModelAdmin):
    list_display = ['user', 'shop', 'is_admin', ]


class ProductAdmin(admin.ModelAdmin):
    list_display = ['product_name', 'shop',
                    'product_code', 'purchases_price', 'quantity', ]


class ServiceAdmin(admin.ModelAdmin):
    list_display = ['service_name', 'shop', 'service_charge', 'service_unit']


class PaymentAdmin(admin.ModelAdmin):
    list_display = ['customer', 'shop',
                    'is_payment_in', 'amount', 'created_at']


class CustomerAdmin(admin.ModelAdmin):
    list_display = ['customer_name', 'shop', 'created_at', 'updated_at']


class FeedbackAdmin(admin.ModelAdmin):
    list_display = ['customer', 'shop', 'created_at', 'updated_at']


admin.site.register(Shop, ShopAdmin)
admin.site.register(ShopUser, ShopUserAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Service, ServiceAdmin)
admin.site.register(Customer, CustomerAdmin)
admin.site.register(Invoice)
admin.site.register(InvoiceSoldItem)
admin.site.register(CashSoldItem)
admin.site.register(CashSale)
admin.site.register(Purchase)
admin.site.register(Feedback,  FeedbackAdmin)
admin.site.register(Payment, PaymentAdmin)
admin.site.register(Expense)


admin.site.site_header = "Patowave Admin"
admin.site.site_title = "Patowave Admin Portal"
admin.site.index_title = "Welcome to Patowave system"
