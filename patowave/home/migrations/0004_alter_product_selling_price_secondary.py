# Generated by Django 3.2.5 on 2022-07-04 08:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0003_alter_payment_description'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='selling_price_secondary',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
    ]
