# -*- coding: utf-8 -*-
# Generated by Django 1.11.13 on 2018-08-01 17:35
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('manager', '0002_auto_20180725_1905'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Member',
        ),
        migrations.AlterField(
            model_name='club',
            name='members',
            field=models.ManyToManyField(to='login.Member'),
        ),
    ]
