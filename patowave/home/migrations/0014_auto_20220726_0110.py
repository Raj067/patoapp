# Generated by Django 3.2.5 on 2022-07-25 22:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0013_cashsalecustomer_description'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='shop',
            name='media_link',
        ),
        migrations.AddField(
            model_name='shop',
            name='business_category',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
        migrations.AddField(
            model_name='shop',
            name='business_type',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
