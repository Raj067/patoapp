from django.db import models
from django.conf import settings

# Create your models here.

User = settings.AUTH_USER_MODEL


class Shop(models.Model):
    name = models.CharField(max_length=100)
    slogan = models.CharField(max_length=100, null=True, blank=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    logo = models.ImageField(upload_to='logo/', blank=True, null=True)
    signature = models.ImageField(
        upload_to='signature/', blank=True, null=True)
    address = models.CharField(max_length=100, null=True, blank=True)
    media_link = models.CharField(max_length=100, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    def get_logo_url(self):
        if not self.logo:
            # return the default image
            return '/static/custom/images/logo-image.png'
        return self.logo.url


class ShopUser(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    # One user can possess several shops or roles
    # hence all the roles possessed by user should be defined here
    is_admin = models.BooleanField(default=True)

    def __str__(self) -> str:
        return f'{self.user} -> {self.shop}'


class Product(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_code = models.CharField(max_length=100, null=True, blank=True)
    purchases_price = models.IntegerField()
    selling_price_primary = models.IntegerField()
    selling_price_secondary = models.IntegerField()
    quantity = models.IntegerField()
    stock_level = models.IntegerField()
    primary_unit = models.CharField(max_length=100)
    secondary_unit = models.CharField(max_length=100)
    rate_unit = models.IntegerField()

    # other details
    product_image = models.ImageField(
        upload_to='products/', blank=True, null=True)

    # Supplier details optional
    supplier_name = models.CharField(max_length=100, null=True, blank=True)
    supplier_number = models.CharField(max_length=100, null=True, blank=True)
    supplier_email = models.EmailField(null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.product_name

    def get_product_image(self):
        if not self.product_image:
            # return the default image
            return '/static/custom/images/product-image.png'
        return self.product_image.url


class Service(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    service_name = models.CharField(max_length=100)
    service_charge = models.IntegerField()
    service_unit = models.CharField(max_length=100)
    service_description = models.CharField(max_length=100)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.service_name


class Customer(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer_name = models.CharField(max_length=100)
    customer_number = models.CharField(max_length=100, null=True, blank=True)
    customer_email = models.EmailField(null=True, blank=True)
    customer_address = models.CharField(max_length=100, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.customer_name


class CashSoldItem(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    price = models.IntegerField()
    product_unit = models.CharField(max_length=100, null=True, blank=True)

    cash_sale_data = models.ForeignKey("CashSale", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class PurchasedItem(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    price = models.IntegerField()
    product_unit = models.CharField(max_length=100, null=True, blank=True)

    cash_sale_data = models.ForeignKey("Purchase", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class InvoiceSoldItem(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    price = models.IntegerField()

    invoice_data = models.ForeignKey("Invoice", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class CashSale(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    sold_items = models.ManyToManyField(
        Shop, blank=True, related_name='sales_data_name', through=CashSoldItem)
    amount = models.IntegerField()

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Invoice(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    amount = models.IntegerField()
    balance_due = models.IntegerField()
    discount = models.IntegerField(default=0)
    description = models.CharField(max_length=500)

    sold_items = models.ManyToManyField(
        Shop, blank=True, related_name='invoice_data_name', through=InvoiceSoldItem)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Purchase(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    amount = models.IntegerField()
    balance_due = models.IntegerField()

    description = models.CharField(max_length=500, null=True, blank=True)

    purchased_items = models.ManyToManyField(
        Shop, blank=True, related_name='purchases_data_name', through=PurchasedItem)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Feedback(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    comments = models.TextField()

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return f"{self.customer}"
# ------------------------------------------


class Payment(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    is_payment_in = models.BooleanField(default=True)
    amount = models.IntegerField()
    description = models.TextField(null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return f"{self.customer}"


class Expense(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    amount = models.IntegerField()
    expenses_category = models.CharField(max_length=500)
    description = models.CharField(max_length=500)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
