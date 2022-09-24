from django.shortcuts import render
from home.models import *
import random
# Create your views here.


def home(request, *args, **kwargs):
    return render(request, 'site/home.html', {})


def single_blog(request, slug, *args, **kwargs):
    blog = Blog.objects.get(slug=slug)
    blogs = [i for i in Blog.objects.all()]
    random.shuffle(blogs)
    blogs = blogs[:3]
    return render(request, 'site/single_blog.html', {'blog': blog, 'blogs': blogs})


def blog(request, *args, **kwargs):
    blogs = Blog.objects.all()
    return render(request, 'site/blog.html', {'blogs': blogs})


def faqs(request, *args, **kwargs):
    my_faqs = Faq.objects.all()
    faqs1 = my_faqs[:len(my_faqs)//2]
    faqs2 = my_faqs[len(my_faqs)//2:]
    return render(request, 'site/faqs.html', {'faqs1': faqs1, 'faqs2': faqs2})


def contact(request, *args, **kwargs):
    return render(request, 'site/contact.html', {})


def terms(request, *args, **kwargs):
    return render(request, 'site/terms.html', {})


def policies(request, *args, **kwargs):
    return render(request, 'site/policies.html', {})


def about(request, *args, **kwargs):
    return render(request, 'site/about.html', {})
