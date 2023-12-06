// To parse this JSON data, do
//
//     final weeklyModel = weeklyModelFromJson(jsonString);

import 'dart:convert';

WeeklyModel weeklyModelFromJson(String str) =>
    WeeklyModel.fromJson(json.decode(str));

String weeklyModelToJson(WeeklyModel data) => json.encode(data.toJson());

class WeeklyModel {
  String? thisDate;
  String? lastDate;
  Week? thisweek;
  Week? lastweek;

  WeeklyModel({
    this.thisDate,
    this.lastDate,
    this.thisweek,
    this.lastweek,
  });

  factory WeeklyModel.fromJson(Map<String, dynamic> json) => WeeklyModel(
        thisDate: json["thisDate"],
        lastDate: json["lastDate"],
        thisweek:
            json["thisweek"] == null ? null : Week.fromJson(json["thisweek"]),
        lastweek:
            json["lastweek"] == null ? null : Week.fromJson(json["lastweek"]),
      );

  Map<String, dynamic> toJson() => {
        "thisDate": thisDate,
        "lastDate": lastDate,
        "thisweek": thisweek?.toJson(),
        "lastweek": lastweek?.toJson(),
      };
}

class Week {
  int? sunday;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;

  Week({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  factory Week.fromJson(Map<String, dynamic> json) => Week(
        sunday: json["Sunday"],
        monday: json["Monday"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thursday: json["Thursday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
      );

  Map<String, dynamic> toJson() => {
        "Sunday": sunday,
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
      };
}
