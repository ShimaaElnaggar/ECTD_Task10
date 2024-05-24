import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper{
  Database? db;

  SqlHelper(){
    _init();
  }


  void _init() async {
   try{

     if(kIsWeb){
       var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('my_db.db');


     } else
     {
       db =  await openDatabase(
           'employee.db',
           version : 1,
           onCreate: ( db , version ){
             print("Database created successfully");
           }
       );
     }
   } catch(error){
     print("The error in creating database : $error");
     }
     }

  }
