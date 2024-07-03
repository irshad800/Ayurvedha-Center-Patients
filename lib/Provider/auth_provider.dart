import 'package:doctor_booking/services/auth_api_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool loading = false;

  Future<void> login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();
      await loginService(username, password, context);
      loading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong')));
      loading = false;
      notifyListeners();
    }
  }
}
