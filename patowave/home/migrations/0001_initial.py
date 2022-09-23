# Generated by Django 3.2.5 on 2022-09-23 21:12

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import tinymce.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Blog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', tinymce.models.HTMLField()),
                ('author', models.CharField(max_length=500)),
                ('title', models.CharField(max_length=500)),
                ('metadata', models.TextField()),
                ('keywords', models.CharField(max_length=500)),
                ('published', models.BooleanField(default=True)),
                ('featured_image', models.ImageField(upload_to='blogs/')),
                ('slug', models.SlugField(unique=True)),
                ('english', models.BooleanField(default=True)),
                ('published_at', models.DateTimeField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='CashSale',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('receipt_no', models.CharField(default='123', max_length=50)),
                ('amount', models.IntegerField()),
                ('discount', models.IntegerField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='CashSaleCustomer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('receipt_no', models.CharField(default='123', max_length=50)),
                ('amount', models.IntegerField()),
                ('discount', models.IntegerField()),
                ('description', models.CharField(blank=True, max_length=500, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField()),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Customer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('customer_name', models.CharField(max_length=100)),
                ('customer_number', models.CharField(max_length=100)),
                ('customer_email', models.EmailField(blank=True, max_length=254, null=True)),
                ('customer_address', models.CharField(blank=True, max_length=100, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Faq',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('question', models.CharField(max_length=500)),
                ('answer', tinymce.models.HTMLField()),
                ('english', models.BooleanField(default=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='GreetingCard',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('card_category', models.CharField(choices=[('thank-you', 'Thank You'), ('offers', 'Offers'), ('good-morning', 'Good Morning')], max_length=100)),
                ('default_text', models.CharField(max_length=500)),
                ('greeting_card', models.ImageField(upload_to='greeting-cards/')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Invoice',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('invoice_no', models.CharField(default='123', max_length=50)),
                ('amount_received', models.IntegerField()),
                ('total_amount', models.IntegerField()),
                ('date_due', models.DateField()),
                ('discount', models.IntegerField(default=0)),
                ('description', models.CharField(max_length=500)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField()),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.customer')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Purchase',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount_paid', models.IntegerField()),
                ('total_amount', models.IntegerField()),
                ('bill_no', models.CharField(default='123', max_length=50)),
                ('description', models.CharField(default='Purchases', max_length=500)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField()),
                ('customer', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='home.customer')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Shop',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('slogan', models.CharField(blank=True, max_length=100, null=True)),
                ('instagram_name', models.CharField(blank=True, max_length=100, null=True)),
                ('phone', models.CharField(blank=True, max_length=15, null=True)),
                ('email', models.EmailField(blank=True, max_length=254, null=True)),
                ('logo', models.ImageField(blank=True, null=True, upload_to='logo/')),
                ('signature', models.ImageField(blank=True, null=True, upload_to='signature/')),
                ('address', models.CharField(blank=True, max_length=100, null=True)),
                ('business_category', models.CharField(blank=True, max_length=200, null=True)),
                ('business_type', models.CharField(blank=True, max_length=200, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='VersionTrack',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('current_version', models.IntegerField()),
                ('version_name', models.CharField(max_length=500)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='ShopUser',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_admin', models.BooleanField(default=True)),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Shedule',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('description', models.TextField()),
                ('dateEvent', models.DateField()),
                ('startTime', models.TimeField()),
                ('endTime', models.TimeField()),
                ('color', models.IntegerField()),
                ('repeat', models.CharField(max_length=15)),
                ('remind', models.IntegerField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Service',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('service_name', models.CharField(max_length=100)),
                ('service_charge', models.IntegerField()),
                ('service_unit', models.CharField(max_length=100)),
                ('service_description', models.CharField(max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='PurchasedItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=100)),
                ('product_id', models.IntegerField()),
                ('quantity', models.IntegerField()),
                ('price', models.IntegerField()),
                ('product_unit', models.CharField(default='Items', max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('purchases_data', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.purchase')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.AddField(
            model_name='purchase',
            name='purchased_items',
            field=models.ManyToManyField(blank=True, related_name='purchases_data_name', to='home.PurchasedItem'),
        ),
        migrations.AddField(
            model_name='purchase',
            name='shop',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop'),
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=100)),
                ('product_code', models.CharField(blank=True, max_length=100, null=True)),
                ('purchases_price', models.IntegerField(default=0)),
                ('selling_price_primary', models.IntegerField()),
                ('selling_price_secondary', models.IntegerField(blank=True, default=0, null=True)),
                ('quantity', models.IntegerField(default=0)),
                ('stock_level', models.IntegerField(default=0)),
                ('primary_unit', models.CharField(max_length=100)),
                ('secondary_unit', models.CharField(blank=True, max_length=100, null=True)),
                ('rate_unit', models.IntegerField(blank=True, null=True)),
                ('is_service', models.BooleanField(default=False)),
                ('product_image', models.ImageField(blank=True, null=True, upload_to='products/')),
                ('supplier_name', models.CharField(blank=True, max_length=100, null=True)),
                ('supplier_number', models.CharField(blank=True, max_length=100, null=True)),
                ('supplier_email', models.EmailField(blank=True, max_length=254, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Payment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('receipt_no', models.CharField(default='123', max_length=50)),
                ('is_payment_in', models.BooleanField(default=True)),
                ('amount', models.IntegerField()),
                ('description', models.CharField(blank=True, max_length=500, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.customer')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='InvoiceSoldItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=100)),
                ('product_id', models.IntegerField()),
                ('quantity', models.IntegerField()),
                ('price', models.IntegerField()),
                ('purchases_price', models.IntegerField()),
                ('product_unit', models.CharField(default='Items', max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('invoice_data', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.invoice')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.AddField(
            model_name='invoice',
            name='shop',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop'),
        ),
        migrations.AddField(
            model_name='invoice',
            name='sold_items',
            field=models.ManyToManyField(blank=True, related_name='invoice_data_name', to='home.InvoiceSoldItem'),
        ),
        migrations.CreateModel(
            name='InventoryTrack',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_id', models.IntegerField()),
                ('product_name', models.CharField(max_length=500)),
                ('quantity_added', models.IntegerField()),
                ('purchases_price', models.IntegerField(default=0)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('comments', models.TextField()),
                ('name', models.CharField(max_length=500)),
                ('phone_number', models.CharField(max_length=50)),
                ('business_name', models.CharField(max_length=500)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
        ),
        migrations.CreateModel(
            name='Expense',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('bill_no', models.CharField(default='123', max_length=50)),
                ('amount', models.IntegerField()),
                ('expenses_category', models.CharField(max_length=200)),
                ('description', models.CharField(default='Expenses', max_length=500)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField()),
                ('customer', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='home.customer')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.AddField(
            model_name='customer',
            name='customer_payment',
            field=models.ManyToManyField(blank=True, related_name='data_customer_payment', to='home.Payment'),
        ),
        migrations.AddField(
            model_name='customer',
            name='shop',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop'),
        ),
        migrations.CreateModel(
            name='CashSoldItemCustomer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=100)),
                ('product_id', models.IntegerField()),
                ('quantity', models.IntegerField()),
                ('price', models.IntegerField()),
                ('purchases_price', models.IntegerField()),
                ('product_unit', models.CharField(max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('cash_sale_customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.cashsalecustomer')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.CreateModel(
            name='CashSoldItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=100)),
                ('product_id', models.IntegerField()),
                ('quantity', models.IntegerField()),
                ('price', models.IntegerField()),
                ('purchases_price', models.IntegerField()),
                ('product_unit', models.CharField(max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('cash_sale_data', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.cashsale')),
                ('shop', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop')),
            ],
            options={
                'ordering': ('-id',),
            },
        ),
        migrations.AddField(
            model_name='cashsalecustomer',
            name='customer',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.customer'),
        ),
        migrations.AddField(
            model_name='cashsalecustomer',
            name='shop',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop'),
        ),
        migrations.AddField(
            model_name='cashsalecustomer',
            name='sold_items',
            field=models.ManyToManyField(blank=True, related_name='sales_data_customer', to='home.CashSoldItemCustomer'),
        ),
        migrations.AddField(
            model_name='cashsale',
            name='shop',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.shop'),
        ),
        migrations.AddField(
            model_name='cashsale',
            name='sold_items',
            field=models.ManyToManyField(blank=True, related_name='sales_data_name', to='home.CashSoldItem'),
        ),
    ]
