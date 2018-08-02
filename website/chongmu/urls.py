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
from django.conf.urls import url, include
from . import views
from login import views as login_views
from django.contrib.auth import views as auth_views


app_name = 'chongmu'
urlpatterns = [
    # ex : /
    url(r'^$', views.index, name='index' ),
    # ex : /main
    url(r'^main/$', views.main, name='main' ),
    
    #url(r'^meta_login/$', login_views.meta, name='meta' ),
    url(r'^meta_login/$', login_views.meta_login, name = 'meta_login1'),

    url(r'^create/$', views.create, name='create' ),
    url(r'^create/exec/$', views.createExec, name='createExec' ),

]












#
