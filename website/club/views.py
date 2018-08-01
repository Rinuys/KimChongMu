from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.views import generic
# Create your views here.

from .models import Club, Rule
from login.models import Member


def index(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    return render(request, 'club/index.html', {'club': club})


def member(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    return render(request, 'club/member.html', {'club':club})


def addMember(request, club_id):
    clubName = request.POST['clubName']
    memberID = request.POST['member_id']

    club = get_object_or_404(Club, name=clubName)
    member = get_object_or_404(Member, member_id=memberID)

    club.members.add(member)
    club.save()

    return HttpResponseRedirect(reverse('club:member', args=(club.id,)))



def rule(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    return render(request, 'club/rule.html', {'club':club})
    
def textMining(request, club_id):
    clubName = request.POST['clubName']
    club = get_object_or_404(Club, name=clubName)
    rule = request.POST['rule']
    #text mining~~~!
    result = False

    if result is True:
        return HttpResponseRedirect(reverse('club:rule', args=(club.id,)))
    else:
        return render(request, 'club/moreInfo.html', {'club': club})
    

def uploadRule(request, club_id): 
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

    return HttpResponseRedirect(reverse('club:rule', args=(club.id,)))


def meeting(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    return render(request, 'club/meeting.html', {'club':club})

def fee(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    return render(request, 'club/fee.html', {'club':club})