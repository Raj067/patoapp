from django.shortcuts import render

# Create your views here.


def privacy_policy(request, *args, **kwargs):
    return render(request, 'privacy_policy.html', {})


def terms_conditions(request, *args, **kwargs):
    return render(request, 'terms.html', {})

def forgot_password(request, *args, **kwargs):
    return render(request, 'forgot-password.html', {})


def tutorials(request, *args, **kwargs):
    return render(request, 'tutorials.html', {})

