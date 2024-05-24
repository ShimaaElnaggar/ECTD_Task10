class EmployeeModel {
  int? id;
  String name;
  String email;
  String phone;
  String address;

  EmployeeModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
}
