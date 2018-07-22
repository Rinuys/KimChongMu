from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from django.views import generic
# Create your views here.

def index(request):
    return render(request, 'manager/index.html', {})

def create(request):
    return render(request, 'manager/create.html', {})

def member(request):
    return render(request, 'manager/member.html', {})

def rule(request):
    return render(request, 'manager/rule.html', {})

def meeting(request):
    return render(request, 'manager/meeting.html', {})

def defaulter(request):
    return render(request, 'manager/defaulter.html', {})
