from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect
from django.urls import reverse
from django.views import generic
import json
# Create your views here.

from .models import Club, Meeting, Invitation, Post, Comment
from login.models import Member

from django.core import serializers
from datetime import date, datetime
import time

def index(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    meetingList = getInvitationList(request)

    posts = club.post_set.all().order_by('created_date')

    return render(request, 'club/index.html', {'club': club, 'meetingList':meetingList, 'posts': posts})

def post(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    member = get_object_or_404(Member, member_id=request.session['member_id'])
    meetingList = getInvitationList(request)

    postText = request.POST['postText']
    club.post_set.create(author=member, text=postText, created_date=datetime.today())

    return HttpResponseRedirect(reverse('club:index', args=(club.id,)))

def comment(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    member = get_object_or_404(Member, member_id=request.session['member_id'])
    meetingList = getInvitationList(request)

    postID = request.POST['postID']
    commentText = request.POST['commentText']
    post = get_object_or_404(Post, id=postID)
    post.comments.create(author=member, text=commentText, created_date=datetime.today())

    return HttpResponseRedirect(reverse('club:index', args=(club.id,)))


def member(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    meetingList = getInvitationList(request)
    return render(request, 'club/member.html', {'club':club, 'meetingList':meetingList})


def addMember(request, club_id):

    memberID = request.POST['member_id']

    club = get_object_or_404(Club, pk=club_id)
    member = get_object_or_404(Member, member_id=memberID)

    club.members.add(member)
    club.save()

    return HttpResponseRedirect(reverse('club:member', args=(club.id,)))


def meeting(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    member = get_object_or_404(Member, member_id=request.session['member_id'])
    meetingList = getInvitationList(request)

    # make json of Meeting Info
    json = makeJson(club, member)

    return render(request, 'club/meeting.html', {'club':club,  'meetingList':meetingList, 'json':json})


def createMeeting(request, club_id):
    club = get_object_or_404(Club, pk=club_id)
    member = get_object_or_404(Member, member_id=request.session['member_id'])

    name = request.POST['name']
    date = request.POST['date']
    hour = request.POST['hour']
    minute = request.POST['minute']
    comment = request.POST['comment']

    time = str(hour)+":"+str(minute)

    meeting = club.meeting_set.create(name = name, date = date, time=time, comment=comment)
    meeting.members.add(member)
    meeting.founder.add(member)
    club.save()

    return HttpResponseRedirect(reverse('club:selectMember', args=(club.id, meeting.id)))


def selectMember(request, club_id, meeting_id):
    club = get_object_or_404(Club, pk=club_id)
    meetingList = getInvitationList(request)
    return render(request, 'club/selectMember.html', {'club':club,  'meetingList':meetingList, 'meeting_id':meeting_id})


def inviteMember(request, club_id, meeting_id):

    club = get_object_or_404(Club, pk=club_id)
    meeting = club.meeting_set.get(pk = meeting_id)
    memberIDList = request.POST.getlist('memberID')

    for memberID in memberIDList:
        member = Member.objects.get(member_id=memberID)

        invitation = Invitation()
        invitation.save()
        meeting.invitation_set.add(invitation)
        member.invitation_set.add(invitation)

        meeting.members.add(member)

    return HttpResponseRedirect(reverse('club:meeting', args=(club.id,)))


def acceptInvitation(request):

    meetingID = request.POST['meetingID']
    accept = request.POST['accept']
    meeting = Meeting.objects.get(id=meetingID)

    invitation = Invitation.objects.get(receiver=request.session['member_id'], meeting=meeting)

    if accept=='yes':
        invitation.accept = True
    elif accept=='no':
        invitation.accept = False
    
    invitation.save()

    # 전체 모임멤버들의 초대수락 여부확인
    state = checkMeetingState(meeting)
    # 모두 수락시 모임장에게 알림쪽지 발송
    if state == 'allAccept':
        member = meeting.founder.all()[0]
        invitation = Invitation()
        invitation.contentType = 1
        invitation.save()
        meeting.invitation_set.add(invitation)
        member.invitation_set.add(invitation)
    
    return HttpResponseRedirect(request.META.get('HTTP_REFERER','/'))


def meetingInfo(request, club_id, meeting_id):
    club = get_object_or_404(Club, pk=club_id)
    meeting = club.meeting_set.get(pk=meeting_id)
    meetingList = getInvitationList(request)

    if date.today() > meeting.date:
        timeout=True
    elif date.today() == meeting.date and datetime.now().time() >= meeting.time:
        timeout=True
    else:
        timeout=False
    
    # 전체 모임멤버들의 초대수락 여부확인
    invitationList = meeting.invitation_set.all()
    state = checkMeetingState(meeting)
    

    return render(request, 'club/meetingInfo.html', {'club':club, 'meetingList':meetingList, 'meeting':meeting, 'timeout':timeout, 'invitationList':invitationList, 'state':state, 'checkCompleted':meeting.checkCompleted})

def confirmMeeting(request, club_id, meeting_id):

    club = get_object_or_404(Club, pk=club_id)
    meeting = club.meeting_set.get(pk=meeting_id)
    meetingList = getInvitationList(request)
    
    # 전체 모임멤버들의 초대수락 여부확인
    state = checkMeetingState(meeting)

    if state == 'allAccept':
    

        # 기존 쪽지 삭제
        meeting.invitation_set.all().delete()

        # 모임원들에게 예치금 납부 쪽지 전송
        for member in meeting.members.all():
            invitation = Invitation()
            invitation.contentType=2
            invitation.save()
            meeting.invitation_set.add(invitation)
            member.invitation_set.add(invitation)

        return HttpResponseRedirect(request.META.get('HTTP_REFERER','/'))

    else:
        return HttpResponseNotFound("없는 페이지 입니다.")



def payFee(request, club_id, meeting_id):

    club = get_object_or_404(Club, pk=club_id)
    meeting = club.meeting_set.get(pk=meeting_id)
    meetingList = getInvitationList(request)
    member = get_object_or_404(Member, member_id=request.session['member_id'])
    
    # 전체 모임멤버들의 초대수락 여부확인
    state = checkMeetingState(meeting)

    if state == 'confirmed':

        invitation = member.invitation_set.get(contentType = '2')
        invitation.delete()

        return HttpResponseRedirect(request.META.get('HTTP_REFERER','/'))

    else:
        return HttpResponseNotFound("없는 페이지 입니다.")

    

    

def meetingAttendance(request, club_id, meeting_id):
    club = get_object_or_404(Club, pk=club_id)
    meeting = club.meeting_set.get(pk=meeting_id)
    meetingList = getInvitationList(request)

    if(meeting.checkCompleted == False):
        memberIDList = []
        for member in meeting.members.all():
            memberIDList = memberIDList + [member.member_id]
        
        return render(request, 'club/meetingAttendance.html', {'club':club, 'meetingList':meetingList, 'meeting':meeting, 'memberIDArray':json.dumps(memberIDList)})
    else:
        return HttpResponseNotFound("없는 페이지 입니다.")


def checkAttendance(request, club_id, meeting_id):
    club = get_object_or_404(Club, pk=club_id)
    meeting = club.meeting_set.get(pk=meeting_id)
    meetingList = getInvitationList(request)
    meeting.checkCompleted = True
    meeting.save()

    return HttpResponseRedirect(reverse('club:meeting', args=(club.id,)))




#----------------------------

def getInvitationList(request):
    invitations = Invitation.objects.filter(receiver=request.session['member_id'])
    meetingList = []
    for invitation in invitations:
        if invitation.accept==None:
            meetingList = meetingList + [(invitation.meeting.club.name,invitation.meeting.name,invitation.meeting.id, invitation.contentType, invitation.meeting.club.id)]
    return meetingList


def makeJson(club, member):
    colorArray = ["#0047BD", "#009543", "#FFB300", "#EA0034", "#8200AC", "#07B9FC", "#9AF000", "#FFE63B", "#FF922A", "#CC72F5", "#763931", "#929292", "#3C5B59", "#4F8D97"]
    
    # 1. 모든 meeting의 name, date, time, url 설정
    json = '{ \"events\": ['
    for meeting in club.meeting_set.all():
        url=reverse('club:meetingInfo', args=(club.id, meeting.id,))
        json = json + '{ \"title\": \"' + meeting.name + '\", ' + '\"start\": \"' + str(meeting.date)+'T'+str(meeting.time) + '\", \"url\": \"'+ url +'\" },'
    json = json.rstrip(',')

    # 2. 표시할 color 선택
    clubList = list(member.club_set.all())
    color = colorArray[clubList.index(club) % len(clubList)]
    json = json + "  ], \"color\": \"" + color +"\", \"textColor\": \"white\" } "

    return json



def checkMeetingState(meeting):

    state = 'inviting'

    allAccept=False
    confirmed=False
    completed=False

    invitationList = meeting.invitation_set.all()
    
    if len(invitationList) == 0:
        state = 'completed'
        return state

    for invitation in invitationList:
        if invitation.contentType == '0' and invitation.accept == True: # 초대 쪽지
            allAccept = True

        elif invitation.contentType == '1': # 모임 확정 요청 쪽지가 존재하는경우
            state = 'allAccept'
            return state

        elif invitation.contentType == '2': # 예치금 송금 요청 쪽지가 존재하는 경우
            state = 'confirmed'
            return state
        
    if(allAccept):
        state = 'allAccept'

    return state

