# Generated by Django 3.2.5 on 2022-09-23 21:32

from django.db import migrations, models
import tinymce.models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0001_initial'),
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
    ]
