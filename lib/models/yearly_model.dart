// To parse this JSON data, do
//
//     final yearlyModel = yearlyModelFromJson(jsonString);

import 'dart:convert';

YearlyModel yearlyModelFromJson(String str) =>
    YearlyModel.fromJson(json.decode(str));

String yearlyModelToJson(YearlyModel data) => json.encode(data.toJson());

class YearlyModel {
  int? year;
  Map<String, int>? month;

  YearlyModel({
    this.year,
    this.month,
  });

  factory YearlyModel.fromJson(Map<String, dynamic> json) => YearlyModel(
        year: json["year"],
        month:
            Map.from(json["month"]!).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month":
            Map.from(month!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
