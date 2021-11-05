import 'package:flutter/material.dart';
//http method
import 'dart:convert';
import 'package:http/http.dart' as http; //ที่จำเป็นสำหรับ request ข้อมูล ร่วมกับ http ใน pubspec
import 'dart:async';

class UpdatePage extends StatefulWidget {
  //const UpdatePage({ Key? key }) : super(key: key);
  final v1,v2,v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  var _v1,_v2,_v3; //ประกาศตัวแปร
  TextEditingController todo_title = TextEditingController(); //ตัวแปรเก็บข้อมูล
  TextEditingController todo_detail = TextEditingController(); //ตัวแปรเก็บข้อมูล

  @override
  void initState() { //ดึงข้อมูลที่มาพร้อม class
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //title
    _v3 = widget.v3; //detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( //สร้าง scaffold เพิ่มทำฟอร์ม
      
      appBar: AppBar(title: Text('แก้ไข'),
      actions: [ //สร้างปุ่มบน bar ด้านบน สำหรับทำ delete
        IconButton(onPressed: () {
          print("Delete ID: $_v1");
          deleteTodo(); //เรียก deleteTodo มาทำงาน
          Navigator.pop(context, 'delete'); // ทำให้หลังกด เหมือนกด back กลับไป

        }, icon: Icon(Icons.delete, color: Colors.red,))
      ],),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // ช่องกรอกข้อมูล title ของ todolist
            TextField(
                    controller: todo_title, //นำตัวแปรมาใช้
                    decoration: InputDecoration(
                        labelText: 'รายการที่ต้องทำ', 
                        border: OutlineInputBorder())),
            SizedBox(height: 30,),

            TextField(
                    minLines: 4,
                    maxLines: 8,
                    controller: todo_detail, //นำตัวแปรมาใช้
                    decoration: InputDecoration(
                        labelText: 'รายละเอีด', 
                        border: OutlineInputBorder())),
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                    onPressed: () {
                        //print('------');
                        //print('title: ${todo_title.text}');
                        //print('title: ${todo_detail.text}');
                        updateTodo();
                        //ลองทำ แจ้งเตือน หลังการ กด แก้ไข
                        final snackBar = SnackBar( 
                        content: const Text('แก้ไขมูลเรียบร้อยแล้ว'),);

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //setState(() { //สร้าง state สำหรับ ไว้ทำ clear หลัง post
                          //todo_title.clear();
                          //todo_detail.clear();
                        //});
                    }, 
                    child: Text("แก้ไข"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20))
                      ),
                      ),
            ),
          ],
    ),
      )
      
    );
  }
  //สำหรับรับส่งค่าระหว่าง mobile และ server django ที่สร้างขึ้นมา
  Future updateTodo() async {
    //ใช้กับ ngrok ถ้า run ใหม่ก็ copy path มาใหม่
    //var url = Uri.https('3acf-2001-fb1-5e-12c4-756a-c460-e9ac-958c.ngrok.io', '/api/post-todolist');
    //ใช้กับ ip เครื่อง หรือ localhost
    var url = Uri.http('172.20.10.14:8000', '/api/update-todolist/$_v1/');
    //var url = Uri.http('localhost:8000', '/api/update-todolist/$_v1/');
    //var url = Uri.http('192.168.1.44:8000', '/api/update-todolist/$_v1/');
    //var url = Uri.http('192.168.1.38:8000', '/api/update-todolist/$_v1/');
    Map<String, String> header = {'Content-type':"application/json"};
    //String jsondata = '{"title":"เขีนยแอฟ flutter", "detail":"ทำแอฟทุกวันเสาร์"}';
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('---result---');
    print(response.body);
  }

  //ไว้ลบข้อมูล
  Future deleteTodo() async {
    var url = Uri.http('172.20.10.14:8000', '/api/delete-todolist/$_v1/');
    //var url = Uri.http('localhost:8000', '/api/delete-todolist/$_v1/');
    //var url = Uri.http('192.168.1.44:8000', '/api/delete-todolist/$_v1/');
    //var url = Uri.http('192.168.1.38:8000', '/api/delete-todolist/$_v1/');
    Map<String, String> header = {'Content-type':"application/json"};
    var response = await http.delete(url, headers: header);
    print('---result---');
    print(response.body);

  }

}