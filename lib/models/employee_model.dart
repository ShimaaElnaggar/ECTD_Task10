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

  Map<String, dynamic> row() => {
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
  };
}
