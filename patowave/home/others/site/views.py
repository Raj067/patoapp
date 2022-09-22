from django.shortcuts import render

# Create your views here.


def home(request, *args, **kwargs):
    return render(request, 'site/home.html', {})


def single_blog(request, slug, *args, **kwargs):
    return render(request, 'site/single_blog.html', {})


def blog(request, *args, **kwargs):
    return render(request, 'site/blog.html', {})


def single_tutorial(request, slug, *args, **kwargs):
    return render(request, 'site/single_tutorial.html', {})


def tutorial(request, *args, **kwargs):
    return render(request, 'site/tutorial.html', {})


def faqs(request, *args, **kwargs):
    return render(request, 'site/faqs.html', {})


def contact(request, *args, **kwargs):
    return render(request, 'site/contact.html', {})


def terms(request, *args, **kwargs):
    return render(request, 'site/terms.html', {})


def policies(request, *args, **kwargs):
    return render(request, 'site/policies.html', {})
