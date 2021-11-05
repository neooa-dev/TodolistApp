import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';

import 'dart:convert';
import 'package:http/http.dart' as http; //ที่จำเป็นสำหรับ request ข้อมูล ร่วมกับ http ใน pubspec
import 'dart:async';

import 'package:todolist/pages/update_todolist.dart';

//สร้าง stf Todolist
class Todolist extends StatefulWidget {
  const Todolist({ Key? key }) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  //ใส่ตัวแปรเพื่อเอามาใช้ใน class
  List todolistitem = ['a','b','c','d'];

  //ชุดที่ทำให้หน้านี้ run ใหม่ทุกครั้งที่เปิด
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist(); //เรียก getTodolist()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ทำปุ่มลอย
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          //เป็นจุดที่จะให้ไปหน้าที่สร้างไว้ คือ Addpage = add.dart
          Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> Addpage())).then((value) {
                setState(() {
                  getTodolist();
                });
              }); 
        } ,
        //ใส่รูปปุ่มที่เป็นเครื่องหมาย +
        child: Icon(Icons.add),
      ),
      //เพื่อสร้างตัวโครงหลัก สำหรับใส่เนื้อหาในหน้า todolist
      appBar: AppBar(
        //สร้างปุ่มบน bar ด้านบน สำหรับทำ refresh
        actions: [ 
        IconButton(onPressed: () {
          setState(() { //เริ่มหน้าใหม่
            getTodolist(); // ไปเรียกการเรียกตารางข้อมูลมาแสดงใหม่
          });
        }, icon: Icon(Icons.refresh, color: Colors.white,))
        ],
        title: Text('Function CRUD'),
      ),
      //body: ListView(children: [
        //Text('All Todolist')  
      //],)
      //นำ widget มาแสดงใน body ของ appbar
      body: todolistCreate(),
    );
  }

  //ทำกล่องทำ list
  Widget todolistCreate() {
    return ListView.builder(
      itemCount: todolistitem.length,
      itemBuilder: (context, index){
        //card จะเป็นการสร้างกล่องให้ โดยที่ไม่ต้อง เซ็ตค่าแบบตารางปกติ
        //ดึงค่าใน list มาแสดงตามลำดับ
      return Card(
        //ทำ list แสดง title
        child: ListTile(
          title: Text("${todolistitem[index]['title']}"), 
          onTap: (){  //ทำไว้สำหรับให้ list กดไปต่อได้
            //ส่งไปต่อที่ UpdatePage ที่อยู่ใน update_todolist.dart
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context)=> UpdatePage( //ส่งไป 3 ค่า
                  todolistitem[index]['id'],
                  todolistitem[index]['title'],
                  //เมื่อถอยหลังกลับมา จะผ่าน then >> มันจะทำการ refresh หน้าจอ และเรียกข้อมูลล่าสุดมาใหม่ กรณี delete/update
                  todolistitem[index]['detail']))).then((value) {
                    setState(() {
                      //print(value);
                      //สำหรับทำ snackbar แถบด้านล่าง เพื่อแจ้งเตือนการ ลบข้อมูลสำเร็จ
                      if (value == 'delete'){
                        final snackBar = SnackBar(
                          content: const Text('ลบข้อมูลเรียบร้อยแล้ว'),
                          //action: SnackBarAction(
                            //label: 'Undo',
                            //onPressed: () {
                            // Some code to undo the change.
                            //},
                          //),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      getTodolist();
                    });
                  }); 
          },
        )
      );
    });
  }

  Future<void> getTodolist() async{
    List alltodo = [];
    var url = Uri.http('172.20.10.14:8000','/api/all-todolist');
    //var url = Uri.http('localhost:8000', '/api/all-todolist');
    //var url = Uri.http('192.168.1.44:8000', '/api/all-todolist');
    //var url = Uri.http('192.168.1.38:8000', '/api/all-todolist');
    var response = await http.get(url);
    //ทำการ decode ชุดข้อมูลทั้งก้อนที่ได้มาเป็น utf8 ก่อนเพื่ออ่านไทยได้
    var result = utf8.decode(response.bodyBytes);
    
    print(result);
    setState(() {
      //ตอนแสดงผล ทำการแปลงข้อมูลที่อ่านออกเป็นรูปแบบ json
      todolistitem = jsonDecode(result);
    });

  }

  



}