

import 'package:ectd_task10/pages/show_employee.dart';
import 'package:ectd_task10/sql_dp.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SqlHelper sqlHelper = SqlHelper();
  sqlHelper.createTables();
  sqlHelper.db;

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  SqlHelper sqlHelper = SqlHelper();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ShowEmployee(employeeData:const [], sqlHelper: sqlHelper),
    );
  }
}

