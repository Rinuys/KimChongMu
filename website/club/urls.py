"""website URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from . import views

app_name = 'club'
urlpatterns = [
    # ex : /club/<int:clubid>/
    url(r'^(?P<club_id>\d+)/$', views.index, name='index' ),
    url(r'^(?P<club_id>\d+)/post/$', views.post, name='post' ),
    url(r'^(?P<club_id>\d+)/comment/$', views.comment, name='comment' ),

    # ex : /club/<int:clubid>/member
    url(r'^(?P<club_id>\d+)/member/$', views.member, name='member' ),
    url(r'^(?P<club_id>\d+)/member/checkMember/$', views.checkMember, name='checkMember' ),
    # ex : /club/<int:clubid>/member/addMember
    url(r'^(?P<club_id>\d+)/member/addMember/$', views.addMember, name='addMember' ),
    
    # ex : /club/<int:clubid>/meeting
    url(r'^(?P<club_id>\d+)/meeting/$', views.meeting, name='meeting' ),
    url(r'^(?P<club_id>\d+)/meeting/createMeeting$', views.createMeeting, name='createMeeting' ),
    url(r'^(?P<club_id>\d+)/meeting/selectMember/(?P<meeting_id>\d+)$', views.selectMember, name='selectMember' ),
    url(r'^(?P<club_id>\d+)/meeting/inviteMember/(?P<meeting_id>\d+)$', views.inviteMember, name='inviteMember' ),

    url(r'^(?P<club_id>\d+)/meeting/meetingInfo/(?P<meeting_id>\d+)$', views.meetingInfo, name='meetingInfo' ),
    url(r'^(?P<club_id>\d+)/meeting/confirmMeeting/(?P<meeting_id>\d+)$', views.confirmMeeting, name='confirmMeeting' ),
    url(r'^(?P<club_id>\d+)/meeting/payFee/(?P<meeting_id>\d+)$', views.payFee, name='payFee' ),


    url(r'^(?P<club_id>\d+)/meeting/meetingAttendance/(?P<meeting_id>\d+)$', views.meetingAttendance, name='meetingAttendance' ),
    url(r'^(?P<club_id>\d+)/meeting/checkAttendance/(?P<meeting_id>\d+)$', views.checkAttendance, name='checkAttendance' ),

    url(r'^acceptInvitation/$', views.acceptInvitation, name='acceptInvitation' ),
    url(r'^(?P<club_id>\d+)/leaveClub$', views.leaveClub, name='leaveClub' ),

]
