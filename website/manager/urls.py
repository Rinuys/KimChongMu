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

app_name = 'manager'
urlpatterns = [
    # ex : /manager
    url(r'^$', views.index, name='index' ),
    # ex : /manager/create
    url(r'^create/$', views.create, name='create' ),
    # ex : /manager/member
    url(r'^member/$', views.member, name='member' ),
    # ex : /manager/rule
    url(r'^rule/$', views.rule, name='rule' ),
    # ex : /manager/meeting
    url(r'^meeting/$', views.meeting, name='meeting' ),
    # ex : /manager/defaulter
    url(r'^defaulter/$', views.defaulter, name='defaulter' ),

]
