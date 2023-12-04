import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagconnectweb/constant/endpoint_constant.dart';
import 'package:tagconnectweb/models/report_model.dart';

class ReportService {
  final String baseUrl = ApiConstants.apiUrl;

  Future<List<ReportModel>> getReports() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl${ApiConstants.userReport}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Parse the response JSON directly as a list
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> data = responseData['data'];

      // Map the list of report data to ReportModels
      return data.map((item) => ReportModel.fromJson(item)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load reports');
    }
  }
}
