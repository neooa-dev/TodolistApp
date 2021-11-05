import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  // const ContactPage({ Key? key }) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("MR.PUVIT MAIKEAW"),
                Text("PUVITM@DBD.GO.TH")
              ],
            ),
          ),
        )
      ],
      
    );
  }
}