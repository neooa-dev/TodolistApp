import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  //const DetailPage({ Key? key }) : super(key: key);
  final v1,v2,v3,v4; // สร้่างตัวแปรข้อมูลที่จะส่ง
  DetailPage(this.v1,this.v2,this.v3,this.v4); //ประการ consturctor ---this = DetailPage.v1

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var _v1,_v2,_v3,_v4; //ประกาศตัวแปร

  @override
  void initState() { //ดึงข้อมูลที่มาพร้อม class
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    _v4 = widget.v4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(_v1, style: TextStyle(fontSize: 30),),
            Text(_v2, style: TextStyle(fontSize: 20, color: Colors.green),),
            Image.network(_v3),
            Text(_v4, style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }
}