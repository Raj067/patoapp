# Generated by Django 3.2.5 on 2022-07-06 17:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0006_greetingcard_default_text'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customer',
            name='customer_address',
            field=models.CharField(default='0679190720', max_length=100),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='customer',
            name='customer_number',
            field=models.CharField(default='0679190720', max_length=100),
            preserve_default=False,
        ),
    ]
