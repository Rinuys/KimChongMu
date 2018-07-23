from django.shortcuts import render

# Create your views here.
#def make_accounts(request):
#    customer_list = Customer.objects.all()#디비에서 Customer table 의 내용 받아옴
#    return render(request, 'login/make_account.html')

def meta_login(request):
    return render(request, 'login/meta.html')

#def chongmu_login(request):
#    return render(request, 'registration/login.html')

def chongmu_login2(request):

    if request.method =='POST':
        username = request.POST['m_id']
        password = request.POST['m_pass']
    user = UserBackend.authenticate(request, customer_id=username, pwd=password) # 직접 만든 custom 인증으로 회원이 맞는지 확인
    #장고의 기본인증은 usermodel을 default로 가지고 있기 때문에 customer에는 적용이 안되므로 직접 만들었음

    if user is not None:
        request.session['member_id'] = username # 인증을 거치고 난 user의 세션 생성
#        customers = Customer.objects.filter(customer_id=username)
#        context = {'customers':customers}
        return redirect('../main')#이거 main.html로 연결시키기
    else:
        return HttpResponse("아이디나 비밀번호가 일치하지 않습니다.")


def make_accounts(request):
    member_list = Member.objects.all()#디비에서 Customer table 의 내용 받아옴
    return render(request, 'login/make_account.html')
def made_new_account(request):
    if request.method =='POST':
        member_id = request.POST['m_id']
        name = request.POST['m_name']
        pwd = request.POST['m_pass']

        new_member=Member.objects.create(member_id=member_id, member_name=member_name, pwd=pwd,)

        new_member.save()
        return redirect('../chongmu_login')















#
