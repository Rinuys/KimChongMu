from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from django.views import generic
# Create your views here.
from django.contrib.auth.decorators import login_required # 로그인해야만 접근할 수 있도록 제한


def index(request):
    return render(request, 'chongmu/index.html', {})

#@login_required(login_url='/meta_login/')
def main(request):
    return render(request, 'chongmu/main.html', {})
