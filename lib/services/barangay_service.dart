import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tagconnectweb/constant/endpoint_constant.dart';
import 'package:tagconnectweb/models/barangay_model.dart';

class BarangayService {
  final String baseUrl = ApiConstants.apiUrl;

  Future<List<BarangayModel>> getbarangays() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.barangayEndpoint}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the "data" list from the response
        List<dynamic> data = responseData['data'];

        // Map the list of role data to BarangayModels
        return data.map((item) => BarangayModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load barangay');
      }
    } catch (e) {
      throw Exception('Failed to load barangay');
    }
  }

  Future<BarangayModel> getbarangayInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiConstants.brgyInfoEndpoint}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the "data" list from the response
        Map<String, dynamic> data = responseData['data'];

        // Map the list of role data to BarangayModels
        return BarangayModel.fromJson(data);
      } else {
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to load barangay');
      }
    } catch (e) {
      throw Exception('Failed to load barangay');
    }
  }

  Future<bool> patchBarangay(BarangayModel barangayModel, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl${ApiConstants.barangayEndpoint}/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
        body: json.encode(barangayModel.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Failed to update barangay: $e');
    }
  }
}
