from django.urls import path
from django.http import HttpResponse

def hello_world(request):
    return HttpResponse("<h1>Hello from Django CI/CD Pipeline!</h1>")

urlpatterns = [
    path('', hello_world),
]
