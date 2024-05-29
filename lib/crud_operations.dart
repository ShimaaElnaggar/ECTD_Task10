
import 'package:ectd_task10/models/employee_model.dart';
import 'package:ectd_task10/sql_dp.dart';

var sqlHelper = SqlHelper();

Future<int> insertEmployee(EmployeeModel employee) async {
  try {
   await  sqlHelper.init();
    await sqlHelper.db!.insert('employee' ,employee.toMap());

  } catch (e) {
    print("Error in inserting row: $e");
  }
  return 1;
}

Future<int> updateEmployee(EmployeeModel employee) async {
 try{
   await sqlHelper.init();
   int result = await sqlHelper.db!.update(
       'employee',
       employee.toMap(),
       where: "id = ?",
       whereArgs: [employee.id]);
   return result;
 }catch(e){
   print("Error in updating employee:$e");
 }
 return -1;
}

Future<void> deleteEmployee(EmployeeModel employee) async {
try{
  await sqlHelper.init();
  await sqlHelper.db!.delete(
    'Employee',
    where: "id = ?",
    whereArgs: [employee.id],
  );
}catch(e){
  print ("Error in deleting employee : $e");
}
}

