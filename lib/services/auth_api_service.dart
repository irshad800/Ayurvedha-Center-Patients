import 'dart:convert';

import 'package:doctor_booking/Screens/TBooking.dart';
import 'package:doctor_booking/services/shared_prefernces.dart';
import 'package:doctor_booking/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> loginService(
    String username, String password, BuildContext context) async {
  try {
    final url = '$baseUrl/Login';

    final body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];

      await shared(token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TBooking()),
      );
    } else {
      throw Exception('Somthing went wrong');
    }
  } catch (error) {
    rethrow;
  }
}
