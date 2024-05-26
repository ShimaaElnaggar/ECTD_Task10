import 'package:ectd_task10/models/employee_model.dart';
import 'package:ectd_task10/pages/add_employee.dart';
import 'package:ectd_task10/sql_dp.dart';
import 'package:flutter/material.dart';

class ShowEmployee extends StatefulWidget {
  List<EmployeeModel> employeeData ;
  var sqlHelper = SqlHelper();

  ShowEmployee(
      {required this.employeeData, required this.sqlHelper, super.key});

  @override
  State<ShowEmployee> createState() => _ShowEmployeeState();
}

class _ShowEmployeeState extends State<ShowEmployee> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Show Employee",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: widget.employeeData.isEmpty
          ? const Center(
              child: Text(
                " No Employee Added Yet!",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20,
                ),
              ),
            )
          : Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable(
             headingTextStyle:const  TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600),
              decoration:
              BoxDecoration(border: Border.all(color: Colors.deepPurple)),
              border: TableBorder.all(color: Colors.deepPurple),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Phone")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Action")),
                ],
                rows: buildRows(),
              ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("Button pressed. Navigating to AddEmployeePage...");
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEmployeePage(
                        employeeData: widget.employeeData,
                        sqlHelper: widget.sqlHelper,
                      )));
          if (result != null) {
            print("Received result from AddEmployeePage: $result");
          }
          setState(() {});
        },
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
          DataCell(Row(
            children: [
              IconButton(onPressed:(){
                updateEmployee(employee);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    AddEmployeePage(
                        employeeData: widget.employeeData,
                        sqlHelper: widget.sqlHelper)));
                print("Employee is updated");
              },icon: const Icon(Icons.edit,color: Colors.deepPurple,)),
              IconButton(onPressed: (){
                deleteEmployee(employee);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    AddEmployeePage(
                        employeeData: widget.employeeData,
                        sqlHelper: widget.sqlHelper)));
                        print("Employee is deleted");
                },icon: const Icon(Icons.delete,color: Colors.red,)),
            ],
          )),
        ],
      );
    }).toList();
  }
  Future<int> updateEmployee(EmployeeModel employee) async {
    int result = await widget.sqlHelper.db!.update(
      'employee',
      employee.toMap(),
      where: "id = ?",
      whereArgs: [employee.id],
    );
    return result;
  }
  Future<void> deleteEmployee(EmployeeModel employee) async {
    await widget.sqlHelper.db!.delete(
      'Employee',
      where: "id = ?",
      whereArgs: [employee.id],
    );
  }
}
