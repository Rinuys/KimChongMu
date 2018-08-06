from django.contrib import admin
from .models import Club, Meeting, Invitation,Post,Comment

admin.site.register(Club)
admin.site.register(Meeting)
admin.site.register(Invitation)
admin.site.register(Post)
admin.site.register(Comment)
# Register your models here.
