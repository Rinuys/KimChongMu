from login.models import Customer

class UserBackend(object):#
    def authenticate(self, customer_id, pwd):
        try:
            customer = Customer.objects.get(customer_id = customer_id)
            if customer.pwd == pwd: # 에러날 수 있음 에러날 경우 그냥 pwd 비교로 바꾸기
                return customer
            else:
                return None
        except Customer.DoesNotExist:
            return None

    # 유저가 없는 경우 is_active는 None이므로 True

    def get_user(self, user_id):#인증기능에서 필수라ㅓㅅ 그냥만들어놓음
        try:
            return Customer.objects.get(pk=customer_id)
        except Customer.DoesNotExist:
            return None
