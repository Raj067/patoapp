# Generated by Django 3.2.5 on 2022-09-24 09:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0005_alter_blog_author_profile'),
    ]

    operations = [
        migrations.AddField(
            model_name='authorblog',
            name='avatar',
            field=models.ImageField(blank=True, null=True, upload_to='author/'),
        ),
    ]
