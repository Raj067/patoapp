# Generated by Django 3.2.5 on 2022-07-11 09:51

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0002_remove_cashsolditem_customer'),
    ]

    operations = [
        migrations.AddField(
            model_name='cashsolditem',
            name='customer',
            field=models.ForeignKey(default='1', on_delete=django.db.models.deletion.CASCADE, to='home.customer'),
            preserve_default=False,
        ),
    ]
