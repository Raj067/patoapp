from django.db import models
from django.conf import settings

# Create your models here.

User = settings.AUTH_USER_MODEL


class Shedule(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    description = models.TextField()
    dateEvent = models.DateField()
    startTime = models.TimeField()
    endTime = models.TimeField()
    color = models.IntegerField()
    repeat = models.CharField(max_length=15)
    remind = models.IntegerField()

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


class Shop(models.Model):
    name = models.CharField(max_length=100)
    slogan = models.CharField(max_length=100, null=True, blank=True)
    instagram_name = models.CharField(max_length=100, null=True, blank=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    logo = models.ImageField(upload_to='logo/', blank=True, null=True)
    signature = models.ImageField(
        upload_to='signature/', blank=True, null=True)
    address = models.CharField(max_length=100, null=True, blank=True)
    business_category = models.CharField(max_length=200, null=True, blank=True)
    business_type = models.CharField(max_length=200, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)

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

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return f'{self.user} -> {self.shop}'


class Product(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_code = models.CharField(max_length=100, null=True, blank=True)
    purchases_price = models.IntegerField(default=0)
    selling_price_primary = models.IntegerField()
    selling_price_secondary = models.IntegerField(
        default=0, null=True, blank=True)
    quantity = models.IntegerField(default=0)
    stock_level = models.IntegerField(default=0)
    primary_unit = models.CharField(max_length=100)
    secondary_unit = models.CharField(max_length=100, null=True, blank=True)
    rate_unit = models.IntegerField(null=True, blank=True)

    is_service = models.BooleanField(default=False)
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

    class Meta:
        ordering = ("-id",)

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

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return self.service_name


class Customer(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer_name = models.CharField(max_length=100)
    customer_number = models.CharField(max_length=100)
    customer_email = models.EmailField(null=True, blank=True)
    customer_address = models.CharField(max_length=100, blank=True, null=True)
    customer_payment = models.ManyToManyField(
        "Payment", blank=True, related_name='data_customer_payment')
    # customer_invoice = models.ManyToManyField(
    #     "Invoice", blank=True, related_name='data_customer_invoice')
    # customer_purchase = models.ManyToManyField(
    #     "Purchase", blank=True, related_name='data_customer_purchase')

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return self.customer_name


class CashSoldItem(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    # product = models.ForeignKey(Product, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_id = models.IntegerField()
    quantity = models.IntegerField()
    price = models.IntegerField()
    purchases_price = models.IntegerField()
    product_unit = models.CharField(max_length=100,)

    cash_sale_data = models.ForeignKey("CashSale", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class CashSoldItemCustomer(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_id = models.IntegerField()
    quantity = models.IntegerField()
    price = models.IntegerField()
    purchases_price = models.IntegerField()
    product_unit = models.CharField(max_length=100,)

    cash_sale_customer = models.ForeignKey(
        "CashSaleCustomer", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class PurchasedItem(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_id = models.IntegerField()
    quantity = models.IntegerField()
    price = models.IntegerField()
    product_unit = models.CharField(max_length=100, default="Items")

    purchases_data = models.ForeignKey("Purchase", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class InvoiceSoldItem(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    product_name = models.CharField(max_length=100)
    product_id = models.IntegerField()
    quantity = models.IntegerField()
    price = models.IntegerField()
    purchases_price = models.IntegerField()
    product_unit = models.CharField(max_length=100, default="Items")

    invoice_data = models.ForeignKey("Invoice", on_delete=models.CASCADE)
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class CashSale(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    sold_items = models.ManyToManyField(
        CashSoldItem, blank=True, related_name='sales_data_name')
    receipt_no = models.CharField(max_length=50, default="123")
    amount = models.IntegerField()
    discount = models.IntegerField()

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class CashSaleCustomer(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    sold_items = models.ManyToManyField(
        CashSoldItemCustomer, blank=True, related_name='sales_data_customer')
    receipt_no = models.CharField(max_length=50, default="123")
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    amount = models.IntegerField()
    discount = models.IntegerField()
    description = models.CharField(max_length=500, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class Invoice(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    invoice_no = models.CharField(max_length=50, default="123")
    amount_received = models.IntegerField()
    total_amount = models.IntegerField()
    date_due = models.DateField()

    discount = models.IntegerField(default=0)
    description = models.CharField(max_length=500)

    sold_items = models.ManyToManyField(
        InvoiceSoldItem, blank=True, related_name='invoice_data_name')
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class Purchase(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(
        Customer, on_delete=models.CASCADE, null=True, blank=True)
    amount_paid = models.IntegerField()
    total_amount = models.IntegerField()
    bill_no = models.CharField(max_length=50, default="123")

    description = models.CharField(max_length=500, default="Purchases")

    purchased_items = models.ManyToManyField(
        PurchasedItem, blank=True, related_name='purchases_data_name')
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class Feedback(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    comments = models.TextField()
    name = models.CharField(max_length=500)
    phone_number = models.CharField(max_length=50)
    business_name = models.CharField(max_length=500)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return f"{self.customer}"
# ------------------------------------------


class Payment(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    receipt_no = models.CharField(max_length=50, default="123")
    is_payment_in = models.BooleanField(default=True)
    amount = models.IntegerField()
    description = models.CharField(max_length=500, null=True, blank=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return f"{self.customer}"


class Expense(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    customer = models.ForeignKey(
        Customer, on_delete=models.CASCADE, null=True, blank=True)
    bill_no = models.CharField(max_length=50, default="123")
    amount = models.IntegerField()
    expenses_category = models.CharField(max_length=200)
    description = models.CharField(max_length=500, default="Expenses")
    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)


class GreetingCard(models.Model):
    categories = [
        ('thank-you', 'Thank You'),
        ('offers', 'Offers'),
        ('good-morning', 'Good Morning'),
    ]
    card_category = models.CharField(max_length=100, choices=categories)
    default_text = models.CharField(max_length=500)
    greeting_card = models.ImageField(
        upload_to='greeting-cards/')

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return f"card {self.id}"


class InventoryTrack(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)

    product_id = models.IntegerField()
    product_name = models.CharField(max_length=500)
    quantity_added = models.IntegerField()
    purchases_price = models.IntegerField(default=0)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return self.product_name


class VersionTrack(models.Model):
    current_version = models.IntegerField()
    version_name = models.CharField(max_length=500)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ("-id",)

    def __str__(self) -> str:
        return self.version_name
