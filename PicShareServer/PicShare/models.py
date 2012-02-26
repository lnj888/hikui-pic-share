#coding:utf-8
from django.db import models
from django.contrib.auth.models import User
class Tag(models.Model):
    tag_name = models.CharField(max_length=10, unique=True)
    
class Status(models.Model):
    timestamp = models.DateTimeField()
    image = models.CharField(max_length=255) #image url
    text = models.CharField(max_length=140, null=True, blank=True) #description
    location = models.CharField(max_length=20, null=True, blank=True)
    STATUS_TYPE_CHOICES=(
        (1,u'原创'),
        (2,u'转发'),
        (3,u'封禁'),
        (4,u'被举报'),
    )
    status_type = models.IntegerField(choices=STATUS_TYPE_CHOICES,default=1)
    tag = models.ForeignKey(Tag, null=True,blank=True)
    user = models.ForeignKey(User)
    
class UserAddition(models.Model):
    user = models.OneToOneField(User,related_name='addition')
    head = models.CharField(max_length=255,null=True, blank=True)
    location = models.CharField(max_length=20, null=True, blank=True)
    introduction = models.TextField()
    