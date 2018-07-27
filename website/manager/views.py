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

def createExec(request):
    clubName = request.POST['name']
    club = Club(name = clubName, founderID = "test")
    club.save()

    id = "test123"
    member = get_object_or_404(Member, memberID=id)
    club.members.add(member)
    club.save()
    return HttpResponseRedirect(reverse('manager:index'))


def member(request):
    id = "test123"
    member = get_object_or_404(Member, memberID=id)
    return render(request, 'manager/member.html', {'member': member})

def addMember(request):
    clubName = request.POST['clubName']
    memberID = request.POST['memberID']

    club = get_object_or_404(Club, name=clubName)
    member = get_object_or_404(Member, memberID=memberID)

    club.members.add(member)
    club.save()

    return HttpResponseRedirect(reverse('manager:member'))



def rule(request):
    id = "test123"
    member = get_object_or_404(Member, memberID=id)
    return render(request, 'manager/rule.html', {'member': member})

def textMining(request):
    clubName = request.POST['clubName']
    club = get_object_or_404(Club, name=clubName)
    rule = request.POST['rule']
    #text mining~~~!
    result = False

    if result is True:
        return HttpResponseRedirect(reverse('manager:rule'))
    else:
        return render(request, 'manager/moreInfo.html', {'club': club})
    

def uploadRule(request): 
    fee = request.POST['fee']
    cycle = request.POST['cycle']
    date = request.POST['date']
    lateness = request.POST['lateness']
    absence = request.POST['absence']
    violationFee = request.POST['violationFee']
    
    clubName = request.POST['clubName']
    club = get_object_or_404(Club, name=clubName)
    club.rule_set.create( ruleID = 1, time=date, balance = fee)
    club.rule_set.create( ruleID = 2, balance=int(violationFee), numberOfLateness=int(lateness), numberOfAbsence=int(absence))
    club.save()

    return HttpResponseRedirect(reverse('manager:rule'))
    
    



def meeting(request):
    return render(request, 'manager/meeting.html', {})



def defaulter(request):
    return render(request, 'manager/defaulter.html', {})
