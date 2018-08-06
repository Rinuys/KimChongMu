from django.db import models
from login.models import Member
from django.utils import timezone

# Create your models here.



class Club(models.Model):
    name = models.CharField(max_length=50)
    founderID = models.CharField(max_length = 50)
    members = models.ManyToManyField(Member)
    numberOfMembers = models.IntegerField(default=0)
    balance = models.IntegerField(default=0)
    photo = models.ImageField(blank=True)

    def __str__(self):
        return self.name


class Meeting(models.Model):
    club = models.ForeignKey(Club, on_delete=models.CASCADE)
    members = models.ManyToManyField(Member)
    name = models.CharField(max_length=50)
    date = models.DateField(default='2018-01-01')
    time = models.TimeField(default='0:0')
    comment = models.TextField(default='')

    def __str__(self):
        return self.name

class Invitation(models.Model):
    meeting = models.ForeignKey(Meeting, on_delete=models.CASCADE, null=True)
    receiver = models.ForeignKey(Member, on_delete=models.CASCADE, null=True)
    accept = models.NullBooleanField(null=True)

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
