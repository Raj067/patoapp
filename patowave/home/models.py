from django.db import models
from django.conf import settings

# Create your models here.

User = settings.AUTH_USER_MODEL


class Shop(models.Model):
    name = models.CharField(max_length=100)
    slogan = models.TextField(null=True, blank=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    email = models.EmailField(null=True)
    logo = models.ImageField(upload_to='logo/', blank=True, null=True)
    address = models.CharField(max_length=100, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

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
    is_admin = models.BooleanField(default=False)


class ProductUnit(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    primary_unit = models.CharField(max_length=100)
    secondary_unit = models.CharField(max_length=100)
    rate_unit = models.IntegerField()

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Product(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_code = models.CharField(max_length=100, null=True, blank=True)
    purchases_price = models.CharField(max_length=100)
    selling_price = models.CharField(max_length=100)
    quantity = models.CharField(max_length=100)
    stock = models.CharField(max_length=100)

    # other details
    product_unit = models.ForeignKey(ProductUnit, on_delete=models.CASCADE)
    product_image = models.ImageField(
        upload_to='products/', blank=True, null=True)

    # Supplier details optional
    supplier_name = models.CharField(max_length=100, null=True, blank=True)
    supplier_number = models.CharField(max_length=100, null=True, blank=True)
    supplier_email = models.EmailField(null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def get_product_image(self):
        if not self.product_image:
            # return the default image
            return '/static/custom/images/product-image.png'
        return self.product_image.url


class Customer(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    # product = models.ForeignKey(Product, on_delete=models.CASCADE)
    customer_name = models.CharField(max_length=100, null=True, blank=True)
    customer_number = models.CharField(max_length=100, null=True, blank=True)
    customer_email = models.EmailField(null=True, blank=True)
    opening_balance = models.CharField(max_length=100, null=True, blank=True)

    # Either to receive or to be paid
    to_receive = models.BooleanField(default=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Sale(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    customer = models.ForeignKey(
        Customer, on_delete=models.CASCADE, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Purchase(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class CustomerFeedback(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    comments = models.TextField()

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

# ------------------------------------------


class Payment(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Transaction(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Expense(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
