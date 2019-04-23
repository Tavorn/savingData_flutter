import 'package:flutter/material.dart';

import '../utils/database_helper.dart';
import '../model/student.dart';

class Entry extends StatefulWidget {

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();

  var db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text("Add Student",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Roboto"
        ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: <Widget>[
          Form(
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "First Name",
                  ),
                ),
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Last Name",
                  ),
                ),
                TextFormField(
                  controller: _contactNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Contact No.",
                  ),
                ),
                TextFormField(
                  controller: _addressLine1Controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Andress Line 1",
                  ),
                ),
                TextFormField(
                  controller: _addressLine2Controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Andress Line 2",
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 5.0,
            right: 5.0,
            bottom: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Add Info", 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  ),
                  padding: EdgeInsets.all(5.0),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (){
                    _addInfo(_firstNameController.text, _lastNameController.text, _contactNumberController.text, _addressLine1Controller.text, _addressLine2Controller.text);
                    Navigator.popAndPushNamed(context, "/home");
                  },
                ),
                RaisedButton(
                  child: Text("Reset", 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  ),
                  padding: EdgeInsets.all(5.0),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (){
                    _firstNameController.clear();
                    _lastNameController.clear();
                   _contactNumberController.clear();
                   _addressLine1Controller.clear();
                   _addressLine2Controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addInfo(String firstName, String lastName, String contactNumber, String addressLine1, String addressLine2) async{
    _firstNameController.clear();
    _lastNameController.clear();
    _contactNumberController.clear();
    _addressLine1Controller.clear();
    _addressLine2Controller.clear();

    Student student = Student(firstName, lastName, contactNumber, addressLine1, addressLine2);
    await db.saveStudent(student);

    // int savedStudent = await db.saveStudent(student);
    // print("Item saved id: $savedStudent");
  }
}