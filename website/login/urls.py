from django.conf.urls import url, include
from login import views as login_views
from django.contrib.auth import views as auth_views

app_name = 'login'
urlpatterns = [
#    url(r'^$', login_views.meta_login, name = 'meta_login1'),#==meta_login
#    url(r'^$', login_views.meta_login, name = 'meta_login3'),#==meta_login
    url(r'^chongmu_login/$', auth_views.login, name = 'chongmu_login'),
#    url(r'^chongmu_login/', login_views.chongmu_login, name='chongmu_login'),
    url(r'^logout/$', auth_views.logout, {'next_page':'/'}, name='logout'),
#    url(r'^mypage', login_views.mypage, name = 'mypage'),
    url(r'^make_accounts', login_views.make_accounts, name = 'make_accounts'),
    url(r'^made_new_account', login_views.made_new_account, name='made_new_account'),
    url(r'^chongmu_login/try_login', login_views.authentication, name='authentication'),

]
