from django.db import models
from login.models import Member
from django.utils import timezone
from django.core.files.storage import FileSystemStorage
from django.conf import settings

# Create your models here.



class Club(models.Model):
    name = models.CharField(max_length=50)
    members = models.ManyToManyField(Member)
    photo = models.ImageField(default='defaultImage.jpg')

    def __str__(self):
        return self.name


class Meeting(models.Model):
    club = models.ForeignKey(Club, on_delete=models.CASCADE)
    members = models.ManyToManyField(Member, related_name="members")
    name = models.CharField(max_length=50)
    date = models.DateField(default='2018-01-01')
    time = models.TimeField(default='0:0')
    fee = models.IntegerField(default=0)
    comment = models.TextField(default='')
    founder = models.ManyToManyField(Member,  related_name="founder")
    checkCompleted = models.BooleanField(default = False)

    def __str__(self):
        return self.name

class Invitation(models.Model):
    meeting = models.ForeignKey(Meeting, on_delete=models.CASCADE, null=True)
    receiver = models.ForeignKey(Member, on_delete=models.CASCADE, null=True)
    accept = models.NullBooleanField(null=True)
    contentType = models.CharField(max_length=1, default=0)
      # 0 : 단순초대
      # 1 : 모두수락시 모임장에게 모임확정 할 것 알림
      # 2 : 모임확정시 모임원들에게 예치금 납부 할 것 알림

    def __str__(self):
        return str(self.meeting) + "->"


class Post(models.Model):
    club = models.ForeignKey(Club, on_delete=models.CASCADE)
    author = models.ForeignKey(Member, on_delete=models.CASCADE)
    text = models.TextField()
    created_date = models.DateTimeField(
            default=timezone.now)



class Comment(models.Model):
    post = models.ForeignKey(Post, related_name='comments')
    author = models.CharField(max_length=200)
    text = models.TextField()
    created_date = models.DateTimeField(default=timezone.now)
