import 'package:ectd_task10/models/employee_model.dart';
import 'package:ectd_task10/pages/show_employee.dart';
import 'package:ectd_task10/sql_dp.dart';
import 'package:ectd_task10/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatefulWidget {
  List<EmployeeModel> employeeData ;
  var sqlHelper = SqlHelper();

  AddEmployeePage(
      {required this.employeeData, required this.sqlHelper, super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  var emailController = TextEditingController();

  var userNameController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Add Employee",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              label: "Name",
              controller: userNameController,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              label: "Email",
              controller: emailController,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              label: "Phone",
              controller: phoneController,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              label: "Address",
              controller: addressController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var employee = EmployeeModel(
                        name: userNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text);
                    insertEmployee(employee);
                    List<EmployeeModel> updatedData = await fetchEmployeeData();

                    setState(() {
                      widget.employeeData = List.from(updatedData);
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowEmployee(
                              employeeData:[employee, ...widget.employeeData],
                              sqlHelper: widget.sqlHelper,
                            )),
                            (route) => false);
                  }


                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> insertEmployee(EmployeeModel employee) async {
    try {
      int insertedId =
          await widget.sqlHelper.db!.insert('employee', employee.toMap());
      if (insertedId != -1) {
        employee.id = insertedId; // Update the ID
        print("Data Inserted Successfully! ID: $insertedId");
        widget.employeeData.add(employee);

      }
      return insertedId;
    } catch (e) {
      print("Error in inserting row: $e");
    }
    return -1;
  }

  Future<List<EmployeeModel>> fetchEmployeeData() async {
    try {
      if (widget.sqlHelper.db == null) {
        await widget.sqlHelper;
      }
      final List<Map<String, dynamic>> maps =
          await widget.sqlHelper.db!.query('employee');

      List<EmployeeModel> fetchedData = maps.map((map) {
        return EmployeeModel(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          phone: map['phone'],
          address: map['address'],
        );
      }).toList();

      return fetchedData;
    } catch (e) {
      print("Error fetching employee data: $e");
      return []; // Return an empty list in case of an error
    }
  }
}
