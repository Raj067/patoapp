# Generated by Django 3.2.5 on 2022-07-11 15:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0003_cashsolditem_customer'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='cashsale',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='cashsolditem',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='customer',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='expense',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='greetingcard',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='invoice',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='invoicesolditem',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='payment',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='product',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='purchase',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='purchaseditem',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='service',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='shop',
            options={'ordering': ('-id',)},
        ),
        migrations.AlterModelOptions(
            name='shopuser',
            options={'ordering': ('-id',)},
        ),
    ]
