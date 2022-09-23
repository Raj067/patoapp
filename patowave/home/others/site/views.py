from django.shortcuts import render
from home.models import *
# Create your views here.


def home(request, *args, **kwargs):
    return render(request, 'site/home.html', {})


def single_blog(request, slug, *args, **kwargs):
    blog = Blogging.objects.get(slug=slug)
    return render(request, 'site/single_blog.html', {'blog': blog})


def blog(request, *args, **kwargs):
    blogs = Blogging.objects.all()
    return render(request, 'site/blog.html', {'blogs': blogs})


def single_tutorial(request, slug, *args, **kwargs):
    return render(request, 'site/single_tutorial.html', {})


def tutorial(request, *args, **kwargs):
    return render(request, 'site/tutorial.html', {})


def faqs(request, *args, **kwargs):
    my_faqs = Faq.objects.all()
    faqs1 = my_faqs[:len(my_faqs)//2]
    faqs2 = my_faqs[len(my_faqs)//2:]
    return render(request, 'site/faqs.html', {'faqs1':faqs1,'faqs2':faqs2})


def contact(request, *args, **kwargs):
    return render(request, 'site/contact.html', {})


def terms(request, *args, **kwargs):
    return render(request, 'site/terms.html', {})


def policies(request, *args, **kwargs):
    return render(request, 'site/policies.html', {})


def about(request, *args, **kwargs):
    return render(request, 'site/about.html', {})
