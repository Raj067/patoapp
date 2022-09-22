from django.shortcuts import render

# Create your views here.

def home_page(request, *args, **kwargs):
    return render(request, 'web/home.html', {})

def demo_page(request, *args, **kwargs):
    return render(request, 'web/demo.html', {})

def about_page(request, *args, **kwargs):
    return render(request, 'web/about.html', {})

def blog_page(request, *args, **kwargs):
    return render(request, 'web/blog.html', {})

def contact_page(request, *args, **kwargs):
    return render(request, 'web/contact.html', {})


# def privacy_policy(request, *args, **kwargs):
#     return render(request, 'privacy_policy.html', {})


# def terms_conditions(request, *args, **kwargs):
#     return render(request, 'terms.html', {})

def forgot_password(request, *args, **kwargs):
    return render(request, 'forgot-password.html', {})


def tutorials(request, *args, **kwargs):
    return render(request, 'tutorials.html', {})

