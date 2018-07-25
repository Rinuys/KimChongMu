from django.db import models

# Create your models here.
class Member(models.Model):
    memberID = models.CharField(max_length = 50)
    nickname = models.CharField(max_length = 50)
    authority = models.IntegerField(default=0)
    attendance = models.IntegerField(default=0)
    balance = models.IntegerField(default=0)
    
    def __str__(self):
        return self.nickname



class Club(models.Model):
    name = models.CharField(max_length=50)
    founderID = models.CharField(max_length = 50)
    members = models.ManyToManyField(Member)
    numberOfMembers = models.IntegerField(default=0)
    balance = models.IntegerField(default=0)

    def __str__(self):
        return self.name



class Rule(models.Model):
    club = models.ForeignKey(Club, on_delete=models.CASCADE)
    ruleID = models.CharField(max_length = 50)
    startTime = models.IntegerField(default=0)
    time = models.IntegerField(default=0)
    balance = models.IntegerField(default=0)
    late = models.IntegerField(default=0)
    numberOfLateness = models.IntegerField(default=0)
    absent = models.IntegerField(default=0)
    numberOfabsence = models.IntegerField(default=0)

    def __str__(self):
        return self.id
