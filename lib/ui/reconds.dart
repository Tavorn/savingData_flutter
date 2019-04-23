import 'package:flutter/material.dart';

import './entry.dart';
import '../model/student.dart';
import '../utils/database_helper.dart';
import '../ui/edit.dart';

class Records extends StatefulWidget {
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {

  final List<Student> _studentRecords = <Student>[];
  var db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _readDatabase();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: false,
                  itemCount: _studentRecords.length,
                  itemBuilder: (_, int index){
                    return Card(
                      child: ListTile(
                        title: _studentRecords[index],
                        onLongPress: ()=> _editStudent(_studentRecords[index], index),
                        trailing: Listener(
                          key: Key(_studentRecords[index].firstName),
                          child: Icon(Icons.remove_circle, color: Colors.red),
                          onPointerDown: (pointerEvent)=> _deleteStudent(_studentRecords[index]),
                          ),
                        ),
                      );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            child: ListTile(
              title: Icon(Icons.add, color: Colors.white),
            ),
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> Entry()),
                );
            },
          ),
        );
      }

      void _readDatabase() async{
        List studentInfo = await db.getStudentRecords();
        //forEach to loop through all items
        //from map function to map each field to an obiect
        studentInfo.forEach((studentInfoItem){
          setState(() {
           _studentRecords.add(Student.fromMap(studentInfoItem)); 
          });
        });
      }

      void _deleteStudent(int id, int index) async{
        await db.deleteRecord(id);
        setState(() {
         _studentRecords.removeAt(index); 
        });
      }

      void _editStudent(Student student, int index) async{
        student = _studentRecords[index];
        var route = MaterialPageRoute(builder: (BuildContext context)=> Edit(student: student));
        Navigator.of(context).push(route);
      }



    }
