from django.shortcuts import render

# Create your views here.


def home_page(request, *args, **kwargs):
    return render(request, 'home.html', {})

def demo_page(request, *args, **kwargs):
    return render(request, 'demo.html', {})

def about_page(request, *args, **kwargs):
    return render(request, 'about.html', {})

def blog_page(request, *args, **kwargs):
    return render(request, 'blog.html', {})

def contact_page(request, *args, **kwargs):
    return render(request, 'contact.html', {})

def privacy_page(request, *args, **kwargs):
    return render(request, 'privacy.html', {})

def terms_page(request, *args, **kwargs):
    return render(request, 'terms.html', {})
