class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? age;
  String? NID;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.age,
    this.NID,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      NID: json['NID'],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "age": age,
    "NID": NID,
  };
}