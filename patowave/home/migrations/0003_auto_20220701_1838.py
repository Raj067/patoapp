# Generated by Django 3.2.5 on 2022-07-01 15:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0002_auto_20220701_1837'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='purchase',
            name='expenses_category',
        ),
        migrations.AlterField(
            model_name='purchase',
            name='description',
            field=models.CharField(blank=True, max_length=500, null=True),
        ),
    ]
