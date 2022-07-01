from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser, UserManager


class CustomUser(AbstractUser):
    # Names
    first_name = models.CharField(max_length=30, blank=True, null=True)
    last_name = models.CharField(max_length=30, blank=True, null=True)

    # Authentication
    username = models.CharField(max_length=15, unique=True)

    # Registration
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # Main Field for authentication
    USERNAME_FIELD = 'username'

    # When user create must need to fill this field
    REQUIRED_FIELDS = []

    objects = UserManager()

    def __str__(self):
        return self.username
