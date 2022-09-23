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


class PurchasedItemInline(admin.TabularInline):
    model = PurchasedItem


class PurchasesAdmin(admin.ModelAdmin):
    inlines = [PurchasedItemInline]
    list_display = ['customer', 'shop',
                    'description', 'amount_paid', 'total_amount', 'created_at']


class CashSoldItemInline(admin.TabularInline):
    model = CashSoldItem


class CashSoldItemCustomerInline(admin.TabularInline):
    model = CashSoldItemCustomer


class CashSaleCustomerAdmin(admin.ModelAdmin):
    inlines = [CashSoldItemCustomerInline]
    list_display = ['shop', 'amount', 'created_at']


class CashSaleAdmin(admin.ModelAdmin):
    inlines = [CashSoldItemInline]
    list_display = ['shop', 'amount', 'created_at']


class PaymentInline(admin.TabularInline):
    model = Payment


class InvoiceInline(admin.TabularInline):
    model = Invoice


class PurchaseInline(admin.TabularInline):
    model = Purchase


class CustomerAdmin(admin.ModelAdmin):
    list_display = ['customer_name', 'shop', 'created_at', 'updated_at']
    inlines = [PaymentInline, InvoiceInline, PurchaseInline]


class FeedbackAdmin(admin.ModelAdmin):
    list_display = ['customer', 'shop', 'created_at', 'updated_at']


class BloggingAdmin(admin.ModelAdmin):
    list_display = ['title', 'author', 'published_at']


class FaqAdmin(admin.ModelAdmin):
    list_display = ['question', 'created_at']


admin.site.register(Shop, ShopAdmin)
admin.site.register(ShopUser, ShopUserAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Service, ServiceAdmin)
admin.site.register(Customer, CustomerAdmin)
admin.site.register(Invoice)
admin.site.register(InvoiceSoldItem)
admin.site.register(CashSoldItem)
admin.site.register(CashSale, CashSaleAdmin)
admin.site.register(CashSaleCustomer, CashSaleCustomerAdmin)
admin.site.register(CashSoldItemCustomer)
admin.site.register(Purchase,  PurchasesAdmin)
admin.site.register(PurchasedItem)
admin.site.register(Feedback,  FeedbackAdmin)
admin.site.register(Payment, PaymentAdmin)
admin.site.register(Expense)
admin.site.register(GreetingCard)
admin.site.register(Shedule)
admin.site.register(InventoryTrack)
admin.site.register(VersionTrack)
admin.site.register(Blogging, BloggingAdmin)
admin.site.register(Faq, FaqAdmin)

admin.site.site_header = "Patowave Admin"
admin.site.site_title = "Patowave Admin Portal"
admin.site.index_title = "Welcome to Patowave system"
