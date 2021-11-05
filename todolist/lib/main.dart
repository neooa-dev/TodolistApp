import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';
import 'package:todolist/pages/calc.dart';
//import 'package:todolist/pages/calc.dart';
import 'package:todolist/pages/contact.dart';
import 'package:todolist/pages/home.dart';
import 'package:todolist/pages/todolist.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //สำหรับปิด ป้าย debug ตอนทดสอบออก
      //title: "Computer Knowleage",
      home: MainPage(), //ตัวหลัก **มันจะ import package home.dart เข้ามาเพิ่ม โดยมี path ตามที่เราสร้าง
    );  
  }
}


//----------------------
class MainPage extends StatefulWidget {
  // const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;
  final tabs = [HomePage(), Todolist(), ContactPage()]; // เก็บค่าได้หลายค่า เริ่มนับจาก 0


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("แอพคำนวณ")),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // หน้าปัจจุบันที่เลือก
        items: [ // หน้าแต่ละหน้ามีไอคอนอะไร?
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.business),label: "APP DBD Service"),
          //BottomNavigationBarItem(icon: Icon(Icons.calendar_view_day),label: "Calculate"),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail),label: "contact"),          
        ],

        onTap: (index) {
          setState(() {
            print(index);
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
