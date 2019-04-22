import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../model/student.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  
  //Internal mean an internal constructor restricted to the class
  DatabaseHelper.internal();

//Factory allows us to implenment
  factory DatabaseHelper() => _instance;

  final String studentTable = "studentTable";
  final String columnId = "id";
  final String columnFirstName = "firstName";
  final String columnLastName = "lastName";
  final String columnContactNumber = "contactNumber";

  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async{
    //Get location of the database
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //Use the join method to join the path to the name of the database which is going to be "studentRecords.db"
    String path = join(documentDirectory.path, "studentRecords.db");
    //Storing the database in ourDB variable
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

//use Sql create table info for column
//Whenever you insert data into a database it return an integer value
  void _onCreate(Database db, int newVersion) async{
    await db.execute(
      "CREATE TABLE $studentTable($columnId INTEGER PRIMARY KEY, $columnFirstName TEXT, $columnLastName TEXT, $columnContactNumber TEXT)"
    );
  }

  Future<int> saveStudent(Student student) async{
    //create an instance of the database client
    var dbClient = await db;
    int result = await dbClient.insert("studentTable", student.toMap());
    return result;
  }

  ////////////////
  ///READ////////
  //////////////
  
  //Get all Student Records
  Future<List> getStudentRecords() async{
    //create an instance of the database client
    var dbClient = await db;

    //perform a raw SQL Query
    var result = await dbClient.rawQuery("SELECT * FROM $studentTable");

    //use the .toList to ensure we return a list
    return result.toList();
  }



}