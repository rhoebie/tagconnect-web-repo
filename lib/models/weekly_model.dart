// To parse this JSON data, do
//
//     final weeklyModel = weeklyModelFromJson(jsonString);

import 'dart:convert';

WeeklyModel weeklyModelFromJson(String str) =>
    WeeklyModel.fromJson(json.decode(str));

String weeklyModelToJson(WeeklyModel data) => json.encode(data.toJson());

class WeeklyModel {
  Week? thisweek;
  Week? lastweek;

  WeeklyModel({
    this.thisweek,
    this.lastweek,
  });

  factory WeeklyModel.fromJson(Map<String, dynamic> json) => WeeklyModel(
        thisweek:
            json["thisweek"] == null ? null : Week.fromJson(json["thisweek"]),
        lastweek:
            json["lastweek"] == null ? null : Week.fromJson(json["lastweek"]),
      );

  Map<String, dynamic> toJson() => {
        "thisweek": thisweek?.toJson(),
        "lastweek": lastweek?.toJson(),
      };
}

class Week {
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;
  int? sunday;

  Week({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory Week.fromJson(Map<String, dynamic> json) => Week(
        monday: json["Monday"],
        tuesday: json["Tuesday"],
        wednesday: json["Wednesday"],
        thursday: json["Thursday"],
        friday: json["Friday"],
        saturday: json["Saturday"],
        sunday: json["Sunday"],
      );

  Map<String, dynamic> toJson() => {
        "Monday": monday,
        "Tuesday": tuesday,
        "Wednesday": wednesday,
        "Thursday": thursday,
        "Friday": friday,
        "Saturday": saturday,
        "Sunday": sunday,
      };
}
