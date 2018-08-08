from django.db import models
from django.utils import timezone
# Create your models here.
class Member(models.Model):
    member_id = models.CharField(primary_key=True,max_length=32) # 이거 ByteField 안된다?
    member_name = models.CharField(max_length=15, blank=True, null=True)
    pwd = models.CharField(max_length=32, blank=True, null=True)
    meta_address = models.CharField(max_length=100, blank=True, null=True)
#    authority = models.IntegerField(default=0)
#    attendance = models.IntegerField(default=0)
#    balance = models.IntegerField(default=0)

    class Meta:
        db_table = 'Member'

#    def publish(self):
#        self.published_date = timezone.now()
#        self.save()

    def __str__(self):
        return self.member_name
