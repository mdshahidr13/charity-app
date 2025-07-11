class Client {
  final String name;
  final String age;
  final String gender;
  final String address;
  final String illness;
  final String phone;
  final String status;

  Client({
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.illness,
    required this.phone,
    required this.status,
  });

  Map<String, String> toMap() => {
    'name': name,
    'age': age,
    'gender': gender,
    'address': address,
    'illness': illness,
    'phone': phone,
    'status': status,
  };
} 