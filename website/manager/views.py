from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.views import generic
# Create your views here.

from .models import Club, Member


def index(request):
    id = "test123"
    member = get_object_or_404(Member, memberID=id)
    return render(request, 'manager/index.html', {'member': member})

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

def createExec(request):
    clubName = request.POST['name']
    club = Club(name = clubName, founderID = "test")
    club.save()

    id = "test123"
    member = get_object_or_404(Member, memberID=id)
    club.members.add(member)
    club.save()
    return HttpResponseRedirect(reverse('manager:index'))