

import 'package:flutter/material.dart';

class ShowEmployee extends StatelessWidget {
  const ShowEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Add Employee",style: TextStyle(color: Colors.white),),
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text("id")),
          DataColumn(label: Text("name")),
          DataColumn(label: Text("email")),
          DataColumn(label: Text("phone")),
          DataColumn(label: Text("adress")),
        ],
        rows: [
          DataRow(
              cells: [
                DataCell(Text("1")),
                DataCell(Text("sama")),
                DataCell(Text("sama@gmail.com")),
                DataCell(Text("0132456578")),
                DataCell(Text("12st,hjghj")),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text("1")),
                DataCell(Text("sama")),
                DataCell(Text("sama@gmail.com")),
                DataCell(Text("0132456578")),
                DataCell(Text("12st,hjghj")),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text("1")),
                DataCell(Text("sama")),
                DataCell(Text("sama@gmail.com")),
                DataCell(Text("0132456578")),
                DataCell(Text("12st,hjghj")),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text("1")),
                DataCell(Text("sama")),
                DataCell(Text("sama@gmail.com")),
                DataCell(Text("0132456578")),
                DataCell(Text("12st,hjghj")),
              ]
          ),
        ],
      ),
    );
  }
}
