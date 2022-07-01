from django.shortcuts import render

# Create your views here.


def dashboard(request, *args, **kwargs):
    print(f'\n\n{request.scheme}\n\n')
    return render(request, 'web/demo.html', {})
