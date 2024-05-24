
import 'package:ectd_task10/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatelessWidget {
  AddEmployeePage({super.key});
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
        title: const Text("Add Employee",style: TextStyle(color: Colors.white),),
      ),
      body: Form(
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
              controller: userNameController,
            ),
            CustomTextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              label: "Address",
              controller: addressController,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple
              ),
                onPressed: (){
                  if(formKey.currentState!.validate()){}
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
}
