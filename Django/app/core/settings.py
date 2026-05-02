import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = 'django-insecure-dummy-key-for-devops-project'
DEBUG = True
ALLOWED_HOSTS = ['*'] # Дозволяємо доступ з будь-яких IP/доменів

INSTALLED_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
]

MIDDLEWARE = []
ROOT_URLCONF = 'core.urls'
WSGI_APPLICATION = 'core.wsgi.application'
DATABASES = {} # Поки залишаємо пустою, щоб не падало без підключення до RDS
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
