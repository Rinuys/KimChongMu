# -*- coding: utf-8 -*-
# Generated by Django 1.11.14 on 2018-08-07 18:49
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('login', '0001_initial'),
        ('club', '0009_club_photo'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='club',
            name='balance',
        ),
        migrations.RemoveField(
            model_name='club',
            name='founderID',
        ),
        migrations.RemoveField(
            model_name='club',
            name='numberOfMembers',
        ),
        migrations.AddField(
            model_name='invitation',
            name='contentType',
            field=models.CharField(default=0, max_length=1),
        ),
        migrations.AddField(
            model_name='meeting',
            name='founder',
            field=models.ManyToManyField(related_name='founder', to='login.Member'),
        ),
        migrations.AlterField(
            model_name='meeting',
            name='members',
            field=models.ManyToManyField(related_name='members', to='login.Member'),
        ),
    ]
