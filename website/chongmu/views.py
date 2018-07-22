from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from django.views import generic
# Create your views here.


def index(request):
    return render(request, 'chongmu/index.html', {})

def post(request):
    return render(request, 'chongmu/post.html', {})

def contact(request):
    return render(request, 'chongmu/contact.html', {})

def about(request):
    return render(request, 'chongmu/about.html', {})

def meta(request):
    return render(request, 'chongmu/meta.html', {})
