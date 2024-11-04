import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

UserModel userModelFromMap(Map<String, dynamic> map) => UserModel.fromJson(map);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? phone;
  String? type;

  UserModel({
    this.uid,
    this.displayName,
    this.email,
    this.phone,
    this.type,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        displayName: json["displayName"],
        email: json["email"],
        phone: json["phone"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "email": email,
        "phone": phone,
        "type": type,
      };
}
