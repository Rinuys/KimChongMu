from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from django.views import generic
# Create your views here.


def index(request):
    return render(request, 'chongmu/index.html', {})

def main(request):
    return render(request, 'chongmu/main.html', {})