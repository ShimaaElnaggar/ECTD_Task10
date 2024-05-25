
import 'package:ectd_task10/models/employee_model.dart';
import 'package:ectd_task10/pages/show_employee.dart';
import 'package:ectd_task10/sql_dp.dart';
import 'package:ectd_task10/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';


class AddEmployeePage extends StatefulWidget {

  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  var emailController = TextEditingController();

  var userNameController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  var formKey = GlobalKey<FormState>();

   final  columnId = 'id';

  final columnName = 'name';

   final columnEmail = 'email';

  final columnPhone = 'phone';

  final columnAddress = 'address';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Add Employee",style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: formKey,
        child: Column(
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
              ),
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    insertEmployee(
                        EmployeeModel(
                            name: userNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: addressController.text
                        ),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context)=>ShowEmployee(

                        )),(route)=>false);
                  }

                },
                child: const Text(
                    "Submit",
                  style: TextStyle(color: Colors.white),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> insertEmployee(EmployeeModel employee) async {
   try{
     var sqlHelper =SqlHelper();
     Map<String, dynamic> row = {
       columnName: employee.name,
       columnEmail: employee.email,
       columnPhone: employee.phone,
       columnAddress: employee.address,
     };
     return await sqlHelper.db!.insert('employee', row);
   }

   catch(e){
    print("Error in inserting row");
  }
  return -1;
}


}
