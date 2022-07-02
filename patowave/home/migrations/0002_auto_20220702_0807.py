# Generated by Django 3.2.5 on 2022-07-02 05:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='customer',
            name='customer_invoice',
            field=models.ManyToManyField(blank=True, related_name='data_customer_invoice', to='home.Invoice'),
        ),
        migrations.AddField(
            model_name='customer',
            name='customer_purchase',
            field=models.ManyToManyField(blank=True, related_name='data_customer_purchase', to='home.Purchase'),
        ),
    ]
