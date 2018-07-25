from django.db import models
from django.utils import timezone
# Create your models here.
class Member(models.Model):
    member_id = models.CharField(primary_key=True,max_length=32)#이거 ByteField 안된다?
    member_name = models.CharField(max_length=15, blank=True, null=True)
#    authority = models.IntegerField(blank=True, null=True)
#    attendance = models.IntegerField(blank=True, null=True)
    pwd = models.CharField(max_length=32, blank=True, null=True)
#    attendance_time = models.DateTimeField('date published', max_length=16, blank=True, null=True)
#account 랑 balance는??여기다 넣어야하나? 권한도? 이거 디비에 뭐저장하고 안해야할지 정하기
#이거 정하기
    class Meta:
        db_table = 'Member'

#    def publish(self):
#        self.published_date = timezone.now()
#        self.save()

    #def __str__(self):
        #return self.member_name
