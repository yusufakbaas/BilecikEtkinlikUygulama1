import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/database_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<bool> login(String email, String password) async {
    final user = await DatabaseService().getUser(email, password);
    if (user != null) {
      _user = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }

  Future<void> register(User user, String password) async {
    await DatabaseService().insertUser(user, password);
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    await DatabaseService().deleteUser(id);
    notifyListeners();
  }

  Future<List<User>> getAllUsers() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        isAdmin: maps[i]['isAdmin'] == 1,
      );
    });
  }
}
