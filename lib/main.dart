import 'package:flutter/material.dart';
import './utils/database_helper.dart';
import './model/student.dart';
import './ui/reconds.dart';

void main() async{
  runApp(
    MaterialApp(
      home: Home(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context)=> Home(),
      },
      debugShowCheckedModeBanner: false,
    ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Records",
        style: TextStyle(
          fontSize: 24.0,
          fontFamily: "Roboto",
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Records(),
    );
  }
}