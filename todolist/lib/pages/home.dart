
import 'package:flutter/material.dart';
import 'package:todolist/pages/detail.dart';

import 'dart:convert';
import 'package:http/http.dart' as http; //ที่จำเป็นสำหรับ request ข้อมูล ร่วมกับ http ใน pubspec
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( //โครงสรา้งของแอฟ
      appBar: AppBar(
        title: Text("DBD Service Identify and Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        //child: FutureBuilder(builder: (context, snapshot){
        //เรียกใช้ผ่าน git https
        child: FutureBuilder(builder: (context,AsyncSnapshot snapshot){  //snapshot คือการได้ข่้อมูลเป็น list{} มาจาก future
          //เรียกใช้แบบ ในเครื่อง
          //var data = json.decode(snapshot.data.toString()); //แปลงข้อมูลบางอย่างเป็นข้อความ >> แล้วมา decode เป็น list data เพื่อสามารถ data.length ได้
          //เรียกใช้ผ่าน git https
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) { //เป็นเหมือนการรันข้อมูลทั้งหมด ที่นับได้ วนออกมาแสดงจนครบตาม itemcount
              //return MyBox(data[index]['title'], data[index]['subtitle'], data[index]['image_url'], data[index]['detail']);
              //เรียกใช้ผ่าน git https
              return MyBox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'], snapshot.data[index]['image_url'], snapshot.data[index]['detail']);
            },
            //itemCount: data.length, );
            //เรียกใช้ผ่าน git https
            itemCount: snapshot.data.length, );
        },
        //เรียกใช้แบบ ในเครื่อง
        //future: DefaultAssetBundle.of(context).loadString('assets/data.json'), //แหล่งข้อมูลที่ไปเอามา อ่านจากในเครื่อง
        future: getData(),
        )
      ),//โครงสรา้ง app
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail){ //สรา้ง widget   มี 3 ค่า title,subtitle,image_url
    var v1,v2,v3,v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container( //เปิดกล่อง return เป็น widget
      margin: EdgeInsets.all(10),   // ปรับให้ กล่องห่างจากระยะขอบจอ เท่าไหร่
      padding: EdgeInsets.all(10), // ปรับให้ตัวหนังสือ ห่างจากกรอบมาเท่าไหร่
      //color: Colors.blue[50],
      height: 160,
      decoration: BoxDecoration( //ตกแต่งกล่อง
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(image_url), //ดึงจาก mybox มาแสดงรูป
          //image: NetworkImage("https://cdn.pixabay.com/photo/2015/01/21/14/14/apple-606761_960_720.jpg"),
          fit: BoxFit.cover, //รูปภาพเต็มตัวกล่อง
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.70), BlendMode.darken)
        )
      ),
      child: Column( //เป็น column
        mainAxisAlignment: MainAxisAlignment.start, //กำหนดตำแหน่งของข้อมูล
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, //ดึงจาก mybox มาแสดงข้อความ
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height:10,),
          Text(
            subtitle, //ดึงจาก mybox มาแสดงข้อความ
            //"คือ ..... อุปรกรณ์ที่ใช้สำหรับการคำนวณและทำงานอื่นๆ",
          style: TextStyle(fontSize: 15, color: Colors.blue),
          ),
          SizedBox(height: 10,),
          TextButton(onPressed: (){ //สำหรับสรา้งปุ่มเพื่อว่ิงไปหน้าถัดไป
              print("Next Page >>>");
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> DetailPage(v1,v2,v3,v4)));
          }, child: Text("Click...") // เมื่อมีการกด อ่านต่อ จะส่งค่าไป 4 ตัว v1-v4 หน้า detail จะรับแล้วเอาไปแสดงผลต่อ
          ) 
        ],
        ),
    );
  }

  Future getData() async { //async จะใช้คู่กับ await ใช้สำหรับ รอ load 
    //https://raw.githubusercontent.com/neooa-dev/BasicAPI/main/data.json
    var url = Uri.https('raw.githubusercontent.com','/neooa-dev/BasicAPI/main/data.json');
    var response = await http.get(url); //รอข้อมูลส่งกลับมาเก็บที่ตัวนี้
    var result = json.decode(response.body);
    return result;
  }


}

