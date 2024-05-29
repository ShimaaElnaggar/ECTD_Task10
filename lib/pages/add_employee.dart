import 'package:ectd_task10/crud_operations.dart';
import 'package:ectd_task10/models/employee_model.dart';
import 'package:ectd_task10/pages/show_employee.dart';
import 'package:ectd_task10/sql_dp.dart';
import 'package:ectd_task10/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatefulWidget {
  List<EmployeeModel> employeeData;
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

  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      EmployeeModel employee = EmployeeModel(
        name: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
      );

      insertEmployee(employee).then((result) async {
        var data = await sqlHelper.db?.query('employee');
        print('data : $data');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ShowEmployee(
                      employeeData: [employee, ...widget.employeeData],
                      sqlHelper: widget.sqlHelper,
                    )),
            (route) => false);
      });
      setState(() {});
    }
  }


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
                  submitForm();
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
}
