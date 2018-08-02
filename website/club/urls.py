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
    # ex : /club/<int:clubid>/member
    url(r'^(?P<club_id>\d+)/member/$', views.member, name='member' ),
    # ex : /club/<int:clubid>/member/addMember
    url(r'^(?P<club_id>\d+)/member/addMember/$', views.addMember, name='addMember' ),

    # ex : /club/<int:clubid>/rule
    url(r'^(?P<club_id>\d+)/rule/$', views.rule, name='rule' ),
    # ex : /club/<int:clubid>/textMining
    url(r'^(?P<club_id>\d+)/rule/textMining/$', views.textMining, name='textMining' ),
    # ex : /club/<int:clubid>/rule/uploadRule
    url(r'^(?P<club_id>\d+)/rule/uploadRule/$', views.uploadRule, name='uploadRule' ),
    
    # ex : /club/<int:clubid>/meeting
    url(r'^(?P<club_id>\d+)/meeting/$', views.meeting, name='meeting' ),
    # ex : /club/<int:clubid>/fee
    url(r'^(?P<club_id>\d+)/fee/$', views.fee, name='fee' ),
]
