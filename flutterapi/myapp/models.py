from django.db import models

# Create your models here.
class Todolist(models.Model): #เป็นการกำหนด field ที่จะเก็บข้อมูลเหมือน sql
    title = models.CharField(max_length=100)
    detail = models.TextField(null=True, blank=True) #เป็นค่าว่างได้

    def __str__(self): #เป็นส่วนที่จะ return เอาเนื้อหาใน todolist ออกมาแสดง เป็นหัวข้อ
        return self.title ,self.detail