from django.shortcuts import render


def dashboard(request, *args, **kwargs):
    return render(request, 'dashboard/dashboard.html', {})
