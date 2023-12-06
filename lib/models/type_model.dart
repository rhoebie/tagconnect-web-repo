// To parse this JSON data, do
//
//     final typeModel = typeModelFromJson(jsonString);

import 'dart:convert';

TypeModel typeModelFromJson(String str) => TypeModel.fromJson(json.decode(str));

String typeModelToJson(TypeModel data) => json.encode(data.toJson());

class TypeModel {
  int? general;
  int? medical;
  int? fire;
  int? crime;

  TypeModel({
    this.general,
    this.medical,
    this.fire,
    this.crime,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        general: json["General"],
        medical: json["Medical"],
        fire: json["Fire"],
        crime: json["Crime"],
      );

  Map<String, dynamic> toJson() => {
        "General": general,
        "Medical": medical,
        "Fire": fire,
        "Crime": crime,
      };
}
