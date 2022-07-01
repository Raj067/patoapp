from .forms import CustomUserCreationForm, CustomUserChangeForm
from django.contrib.auth.admin import UserAdmin
from django.contrib import admin
from .models import CustomUser
# Register your models here.


class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ['username',
                    'first_name', 'last_name', 'last_login', 'created_at']


admin.site.register(CustomUser, CustomUserAdmin)
