from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from django.views import generic
# Create your views here.

def index(request):
    return render(request, 'member/index.html', {})

def clubs(request):
    return render(request, 'member/clubs.html', {})

def fee(request):
    return render(request, 'member/fee.html', {})

def meeting(request):
    return render(request, 'member/meeting.html', {})

def violation(request):
    return render(request, 'member/violation.html', {})
