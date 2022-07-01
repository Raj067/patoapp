from django.contrib import admin
from .models import *

# Register your models here.

admin.site.register(Shop)
admin.site.register(ShopUser)
admin.site.register(Product)
admin.site.register(ProductUnit)
admin.site.register(Customer)
admin.site.register(Sale)
admin.site.register(Purchase)
admin.site.register(CustomerFeedback)
admin.site.register(Transaction)
admin.site.register(Payment)
admin.site.register(Expense)


admin.site.site_header = "Patowave Admin"
admin.site.site_title = "Patowave Admin Portal"
admin.site.index_title = "Welcome to Patowave system"
