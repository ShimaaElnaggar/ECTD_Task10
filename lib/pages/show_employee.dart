
import 'package:ectd_task10/models/employee_model.dart';
import 'package:ectd_task10/pages/add_employee.dart';
import 'package:ectd_task10/sql_dp.dart';
import 'package:flutter/material.dart';

class ShowEmployee extends StatefulWidget {
 List <EmployeeModel> employeeData = [];
 var sqlHelper = SqlHelper();
  ShowEmployee({required this.employeeData,required this.sqlHelper,super.key});

  @override
  State<ShowEmployee> createState() => _ShowEmployeeState();
}

class _ShowEmployeeState extends State<ShowEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Show Employee",style: TextStyle(color: Colors.white),),
      ),
      body: widget.employeeData.isEmpty? const Center(
        child: Text(
            " No Employee Added Yet!",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
          ),
        ),
      ):DataTable(
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Phone")),
          DataColumn(label: Text("Address")),
        ],
        rows: buildRows(),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEmployeePage(
                    employeeData: widget.employeeData,
                    sqlHelper: widget.sqlHelper,
                  ))); },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<DataRow> buildRows() {
    return widget.employeeData.map((employee) {
      return DataRow(
        cells: [
          DataCell(Text(employee.id.toString())),
          DataCell(Text(employee.name)),
          DataCell(Text(employee.email)),
          DataCell(Text(employee.phone)),
          DataCell(Text(employee.address)),
        ],
      );
    }).toList();
  }
}
