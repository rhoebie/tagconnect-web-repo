// To parse this JSON data, do
//
//     final monthlyModel = monthlyModelFromJson(jsonString);

import 'dart:convert';

MonthlyModel monthlyModelFromJson(String str) =>
    MonthlyModel.fromJson(json.decode(str));

String monthlyModelToJson(MonthlyModel data) => json.encode(data.toJson());

class MonthlyModel {
  String? month;
  int? year;
  Map<String, int>? dates;

  MonthlyModel({
    this.month,
    this.year,
    this.dates,
  });

  factory MonthlyModel.fromJson(Map<String, dynamic> json) => MonthlyModel(
        month: json["month"],
        year: json["year"],
        dates:
            Map.from(json["dates"]!).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "dates":
            Map.from(dates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
