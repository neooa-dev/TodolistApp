import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  //const CalculatePage({ Key? key }) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {


  // ตำแหน่งสำหรับเก็บข้อมูลของค่าที่ user กรอกเข้ามา
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController(); // ช่องสำหรับเก็บจำนวน
  // double price = 10; // ช่องสำหรับเก็บราคาสินค้า ใส่ค่าไปเลย
  TextEditingController result = TextEditingController();

  @override
  void initState() {
    // ฟังชั่นพิเศษที่ใช้สำหรับการตั้งค่าในตอนแรก
    super.initState();

    result.text = "ซื้อแอปเปิ้ลจำนวน x ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด x บาท";

  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
              child: Column(
            children: [
              Image.asset('assets/apple.png', width: 300, ),
              Text("โปรแกรมคำนวณ", style: TextStyle(fontSize: 30),),
              TextField(
                  controller: price,
                  decoration: InputDecoration(
                      labelText: 'ราคาสินค้า', 
                      border: OutlineInputBorder())),
              SizedBox(height: 20),
              TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                      labelText: 'จำนวนแอปเปิ้ล', 
                      border: OutlineInputBorder())),
              SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                    var cal = double.parse(quantity.text) * double.parse(price.text) ; // วิธีการแปลงข้อความเป็นตัวเลข: double.parse(quantity.text)
                    print("Apple Qauntity: ${quantity.text} Total: $cal Baht");

                    setState(() {
                      result.text = "ซื้อแอปเปิ้ลจำนวน ${quantity.text} ผล ราคาผลละ 10 บาท รวมลูกค้าต้องจ่ายทั้งหมด $cal บาท";
                    });

                }, 
                child: Text("คำนวณ"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff60e00b)),
                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))
                  ),
                  ),
              Text(result.text, style: TextStyle(fontSize: 20),)
            ],
          )),
        ),
      ],
    );
  }
}