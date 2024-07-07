import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/database_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<void> register(User user, String password) async {
    await DatabaseService().insertUser(user, password);
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _user = await DatabaseService().getUser(email, password);
    notifyListeners();
    return _user != null;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
