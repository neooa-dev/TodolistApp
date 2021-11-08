from django.urls import path
from .views import * #*คือการดึงมาทุกฟังก์ชั่นใน view.py  หรือระบุ ก็ได้
urlpatterns = [
    path('', Home),
    path('api/all-todolist/',all_todolist), #localhost:8000/api/all-todolist
    path('api/post-todolist', post_todolist), #localhost:8000/api/post-todolist
    path('api/update-todolist/<int:TID>/', update_todolist), #localhost:8000/api/update-todolist/ ตามด้วย id /
    path('api/delete-todolist/<int:TID>/', delete_todolist) #localhost:8000/api/delete-todolist/ ตามด้วย id /
]