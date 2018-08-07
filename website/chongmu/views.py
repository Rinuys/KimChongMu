from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.views import generic
# Create your views here.
from django.contrib.auth.decorators import login_required # 로그인해야만 접근할 수 있도록 제한
from login.models import Member
from club.models import Club, Invitation
from club.views import getInvitationList, makeJson


def index(request):
    return render(request, 'chongmu/index.html', {})


#<<<<<<< HEAD
#@login_required(login_url='/meta_login/')
#=======

#>>>>>>> b58bbea9466aa08a62a4401c62f693bbcb6e1ad6

def main(request):
    member = get_object_or_404(Member, member_id=request.session['member_id'])
    meetingList = getInvitationList(request)


    jsonArray = "["
    for club in member.club_set.all():
        jsonArray = jsonArray + makeJson(club, member) + ','
    jsonArray = jsonArray.rstrip(',')
    jsonArray = jsonArray+"]"

    return render(request, 'chongmu/main.html', {'member':member, 'meetingList':meetingList, 'jsonArray':jsonArray})


def create(request):
    meetingList = getInvitationList(request)
    return render(request, 'chongmu/create.html', {'meetingList':meetingList})

def createExec(request):
    clubName = request.POST['clubName']
    clubPhoto = request.FILES['clubPhoto']
    club = Club(name = clubName, founderID = request.session['member_id'], photo=clubPhoto)
    club.save()

    member = get_object_or_404(Member, member_id=request.session['member_id'])
    club.members.add(member)
    club.save()

    return HttpResponseRedirect(reverse('club:index', args=(club.id,)))

    return HttpResponseRedirect(reverse('club:index', args=(club.id,)))


def mypage(request):
    meetingList = getInvitationList(request)
    return render(request, 'chongmu/mypage.html', {'meetingList':meetingList})
