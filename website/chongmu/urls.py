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

app_name = 'chongmu'
urlpatterns = [
    # ex : /
    url(r'^$', views.index, name='index' ),
    # ex : /main
    url(r'^main/$', views.main, name='main' ),
    # ex : /about
    url(r'^about/$', views.about, name='about' ),
    # ex : /guide
    url(r'^guide/$', views.guide, name='guide' ),

    # ex : /post
    url(r'^post/$', views.post, name='post' ),
    # ex : /contact
    url(r'^contact/$', views.contact, name='contact' ),
    # ex : /meta
    url(r'^meta/$', views.meta, name='meta' ),

]
