class PhoneNumberModel {
  int? id;
  String name;
  String phoneNumber;
  PhoneNumberModel({this.id, required this.name, required this.phoneNumber});

  factory PhoneNumberModel.fromMap(Map<String, dynamic> json) => PhoneNumberModel(
      id: json['id'], name: json["name"], phoneNumber: json["phoneNumber"]);

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phoneNumber": phoneNumber,
  };
}