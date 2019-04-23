import 'package:flutter/material.dart';

import '../model/student.dart';
import '../utils/database_helper.dart';

class Edit extends StatefulWidget {
  Student student;

  Edit({Key key, this.student}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();

  var db = DatabaseHelper();

  @override
  void initState() {
    /*
    This method is called when the object is inserted into the tree to use...
    the Student object that was push place widget before student
    */
    super.initState();
    _firstNameController.text = widget.student.firstName;
    _lastNameController.text = widget.student.lastName;
    _contactNumberController.text = widget.student.contactNumber;
    _addressLine1Controller.text = widget.student.addressLine1;
    _addressLine2Controller.text = widget.student.addressLine2;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text("Update Student",
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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Address Line 1",
                  ),
                ),
                TextFormField(
                  controller: _addressLine2Controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    labelText: "Address Line 2",
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
                  child: Text("Update Info", 
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
                    _updateStudentRecord(_firstNameController.text, _lastNameController.text, _contactNumberController.text, _addressLine1Controller.text, _addressLine2Controller.text);
                    Navigator.popAndPushNamed(context, "/home");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateStudentRecord(String firstName, String lastName, String contactNamber, String addressLine1, String addressLine2) async{
    Student student = Student.fromMap({
      "firstName": firstName,
      "lastName": lastName,
      "contactNumber": contactNamber,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "id": widget.student.id,
    });
    await db.updateRecords(student);
  }





}