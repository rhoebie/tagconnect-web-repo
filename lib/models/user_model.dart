// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? roleId;
  String? firstname;
  String? middlename;
  String? lastname;
  int? age;
  dynamic birthdate;
  dynamic contactnumber;
  String? address;
  String? email;
  dynamic image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.roleId,
    this.firstname,
    this.middlename,
    this.lastname,
    this.age,
    this.birthdate,
    this.contactnumber,
    this.address,
    this.email,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        roleId: json["role_id"],
        firstname: json["firstname"],
        middlename: json["middlename"],
        lastname: json["lastname"],
        age: json["age"],
        birthdate: json["birthdate"],
        contactnumber: json["contactnumber"],
        address: json["address"],
        email: json["email"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "firstname": firstname,
        "middlename": middlename,
        "lastname": lastname,
        "age": age,
        "birthdate": birthdate,
        "contactnumber": contactnumber,
        "address": address,
        "email": email,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
