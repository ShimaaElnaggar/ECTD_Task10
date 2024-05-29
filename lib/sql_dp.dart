import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper{
  Database? db;

  Future<void> init() async {
   try{

     if(kIsWeb){
       var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('my_db.db');


     } else
     {
       db =  await openDatabase(
           'employee.db',
           version : 1,
           onCreate: ( Database db , int version ){
             print("Database created successfully");
           }
       );
     }
   } catch(error){
     print("The error in creating database : $error");
     }
     }

  Future<void> createTables()async{
    try{
      if (db == null) {
        await init();
      }
      await db!.execute('''
        CREATE TABLE IF NOT EXISTS employee (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            phone TEXT NOT NULL,
            address TEXT NOT NULL
        )
        ''');
      print("Table created Successfully!");
    }catch(error){
      print("Error in creating tables: $error");
    }
  }

  }
