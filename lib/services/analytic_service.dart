import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagconnectweb/constant/endpoint_constant.dart';
import 'package:tagconnectweb/models/monthly_model.dart';
import 'package:tagconnectweb/models/type_model.dart';
import 'package:tagconnectweb/models/weekly_model.dart';
import 'package:tagconnectweb/models/yearly_model.dart';

class AnalyticService {
  final String baseUrl = ApiConstants.apiUrl;

  Future<TypeModel> getTypeCount() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.countTypeEndpoint}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        Map<String, dynamic> data = responseData['data'];

        return TypeModel.fromJson(data);
      } else {
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to load Count');
      }
    } catch (e) {
      throw Exception('Failed to load Count');
    }
  }

  Future<YearlyModel> getYearlyReport(int year) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConstants.yearlyReportEndpoint}'),
        body: json.encode({'year': year}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        Map<String, dynamic> data = responseData['data'];

        return YearlyModel.fromJson(data);
      } else {
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to load getYearlyReport');
      }
    } catch (e) {
      throw Exception('Failed to load getYearlyReport: $e');
    }
  }

  Future<MonthlyModel> getMonthlyReport(String month) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiConstants.yearlyReportEndpoint}'),
        body: json.encode({'month': month}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        Map<String, dynamic> data = responseData['data'];

        return MonthlyModel.fromJson(data);
      } else {
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to load getMonthlyReport');
      }
    } catch (e) {
      throw Exception('Failed to load getMonthlyReport');
    }
  }

  Future<WeeklyModel> getWeeklyReport() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.yearlyReportEndpoint}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        Map<String, dynamic> data = responseData['data'];

        return WeeklyModel.fromJson(data);
      } else {
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to load getWeeklyReport');
      }
    } catch (e) {
      throw Exception('Failed to load getWeeklyReport');
    }
  }
}
