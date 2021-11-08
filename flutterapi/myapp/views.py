from django.shortcuts import render
from django.http import JsonResponse
from rest_framework import response


from rest_framework.response import Response #1
from rest_framework.decorators import api_view #2
from rest_framework import serializers, status #3
from .serializers import TodolistSerializer #4
from .models import Todolist #5

# Create your views here.

#GET Data
@api_view(['GET']) #2
def all_todolist(request):
    alltodolist = Todolist.objects.all() #5 #ดึงข้อมูลจาก model todolist เหมือน select * from...
    serializer = TodolistSerializer(alltodolist,many=True) #4
    return Response(serializer.data, status=status.HTTP_200_OK)#1,3 #ส่งออกไปผ่านหน้า response ของมันเอง


#POST Data (save data to db)
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodolistSerializer(data=request.data)
        if serializer.is_valid(): #ตรวจสอบก่อน save
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED) #กรณีถูกต้อง
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND) #กรณีไม่สำเร็จ


#PUT Data
@api_view(['PUT'])
def update_todolist(request,TID):
     #ตัวอย่างเช่น localhost:8000/api/update-todolist/13
    todo = Todolist.objects.get(id=TID) #จากตาราง Todolist getมันออกมา
    if request.method == 'PUT':
        data = {}
        serializer = TodolistSerializer(todo,data=request.data) #ระบุ todo เพื่อเช็ค id ก่อน จะบันทึกกลับเข้าไป
        if serializer.is_valid(): #ตรวจสอบก่อน save
            serializer.save()
            data['status'] = 'updated'
            return Response(data=data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)


#Delete Data
@api_view(['DELETE'])
def delete_todolist(request,TID):
     #ตัวอย่างเช่น localhost:8000/api/delete-todolist/13
    todo = Todolist.objects.get(id=TID) #จากตาราง Todolist getมันออกมา
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        
        return Response(data=data, status=statuscode)


data = [
    {
        "title":"Laptop is ?",
        "subtitle":"คือ ..... อุปรกรณ์ที่ใช้สำหรับการคำนวณและทำงานอื่นๆ",
        "image_url":"https://raw.githubusercontent.com/neooa-dev/BasicAPI/main/apple.jpg", 
        "detail":"เครื่องคำนวณอิเล็กทรอนิกส์โดยใช้วิธีทางคณิตศาสตร์ประกอบด้วยฮาร์ดแวร์ (ส่วนตัวเครื่องและอุปกรณ์) \n และซอฟต์แวร์ (ส่วนชุดคำสั่ง หรือโปรแกรมที่สั่งให้คอมพิวเตอร์ทำงาน) สามารถทำงานคำนวณผล \n และเปรียบเทียบค่าตามชุดคำสั่งด้วยความเร็วสูงอย่างต่อเนื่อง และอัตโนมัติ."
    },
    {
        "title":"Flutter is ?",
        "subtitle":"Mobile app and web app",
        "image_url":"https://raw.githubusercontent.com/neooa-dev/BasicAPI/main/laptop.jpg",
        "detail":"เครื่องคำนวณอิเล็กทรอนิกส์โดยใช้วิธีทางคณิตศาสตร์ประกอบด้วยฮาร์ดแวร์ (ส่วนตัวเครื่องและอุปกรณ์) \n และซอฟต์แวร์ (ส่วนชุดคำสั่ง หรือโปรแกรมที่สั่งให้คอมพิวเตอร์ทำงาน) สามารถทำงานคำนวณผล \n และเปรียบเทียบค่าตามชุดคำสั่งด้วยความเร็วสูงอย่างต่อเนื่อง และอัตโนมัติ."
    },
    {
        "title":"Python is ",
        "subtitle":"programming ",
        "image_url":"https://raw.githubusercontent.com/neooa-dev/BasicAPI/main/work.jpg",
        "detail":"เครื่องคำนวณอิเล็กทรอนิกส์โดยใช้วิธีทางคณิตศาสตร์ประกอบด้วยฮาร์ดแวร์ (ส่วนตัวเครื่องและอุปกรณ์) \n และซอฟต์แวร์ (ส่วนชุดคำสั่ง หรือโปรแกรมที่สั่งให้คอมพิวเตอร์ทำงาน) สามารถทำงานคำนวณผล \n และเปรียบเทียบค่าตามชุดคำสั่งด้วยความเร็วสูงอย่างต่อเนื่อง และอัตโนมัติ."
    }
]

def Home (request):
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii': False})