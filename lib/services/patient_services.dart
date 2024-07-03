import 'dart:convert';

import 'package:doctor_booking/models/PatientModel.dart';
import 'package:doctor_booking/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<PatientModel> getPatientService() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var response = await http.get(
      Uri.parse("$baseUrl/PatientList"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      print(decoded);
      return PatientModel.fromJson(decoded);
    } else {
      throw Exception('Failed to load patient list');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> postPatientService(Patient patientData) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var response = await http.post(
      Uri.parse("$baseUrl/addPatient"), // Replace with your API endpoint
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(patientData.toJson()),
    );

    if (response.statusCode == 201) {
      var decoded = jsonDecode(response.body);
      print('Patient added successfully: $decoded');
    } else {
      throw Exception('Failed to add patient: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
    rethrow;
  }
}
