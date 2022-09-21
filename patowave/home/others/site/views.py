from django.shortcuts import render

# Create your views here.


def home(request, *args, **kwargs):
    return render(request, 'site/home.html', {})


def single_blog(request, slug, *args, **kwargs):
    return render(request, 'site/single_blog.html', {})


def blog(request, *args, **kwargs):
    return render(request, 'site/blog.html', {})
