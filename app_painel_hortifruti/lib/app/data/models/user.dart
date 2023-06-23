class UserModel {
  String name;
  String email;
  String? phone;

  UserModel({
    required this.name,
    required this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['nome'],
        email: json['email'],
        phone: json['telefone'],
      );
}
