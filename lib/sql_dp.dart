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
  void createTables()async{
    try{
      await db!.execute("""
    Create table if not exists employee (
    id Integer primary key,
    name String not null,
    email String not null,
    phone String not null,
    address String not null
    )
    """);
    }catch(error){
      print("Error in creating tables: $error");
    }
  }
  }
