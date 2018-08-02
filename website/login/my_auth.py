from login.models import Member

class UserBackend(object):#
    def authenticate(self, member_id, pwd):
        try:
            member = Member.objects.get(member_id = member_id)
            if member.pwd == pwd: # 에러날 수 있음 에러날 경우 그냥 pwd 비교로 바꾸기
                return member
            else:
                return None
        except Member.DoesNotExist:
            return None

    # 유저가 없는 경우 is_active는 None이므로 True

    def user_can_authenticate(self, user):
        is_active = getattr(user, 'is_active', None) # 유저가 활성화 되었는지
        return is_active or is_active is None # 유저가 없는 경우 is_active는 None이므로 True

    def get_user(self, user_id):#인증기능에서 필수라ㅓㅅ 그냥만들어놓음
        try:
            return Member.objects.get(pk=member_id)
        except Member.DoesNotExist:
            return None
