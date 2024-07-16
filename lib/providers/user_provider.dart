// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart'; // Flutter'ın Material Design bileşenleri için gerekli paket.

import '../models/user_model.dart'; // User modelini içeren dosya import ediliyor.
import '../services/database_service.dart'; // Veritabanı servislerini içeren dosya import ediliyor.

// UserProvider sınıfı, ChangeNotifier sınıfından türetiliyor.
// Bu sınıf, Flutter'ın state management (durum yönetimi) için kullanılan bir sınıftır.
class UserProvider with ChangeNotifier {
  // _user adında özel (private) bir değişken oluşturuluyor ve User nesnesini tutuyor.
  User? _user;

  // _user değişkeninin sadece okunabilir bir kopyasını döndüren getter metodu.
  User? get user => _user;

  // Kullanıcı girişini gerçekleştiren asenkron metod.
  Future<bool> login(String email, String password) async {
    // Veritabanı servisinden kullanıcı bilgileri çekiliyor.
    final user = await DatabaseService().getUser(email, password);
    // Eğer kullanıcı bulunursa
    if (user != null) {
      _user = user; // _user değişkenine atanıyor.
      notifyListeners(); // Dinleyicilere (listeners) veri değişikliği bildiriliyor.
      return true; // Giriş başarılı ise true döndürülüyor.
    }
    return false; // Giriş başarısız ise false döndürülüyor.
  }

  // Kullanıcı çıkışını gerçekleştiren asenkron metod.
  Future<void> logout() async {
    _user = null; // _user değişkeni null yapılıyor.
    notifyListeners(); // Dinleyicilere (listeners) veri değişikliği bildiriliyor.
  }

  // Yeni bir kullanıcı kaydeden asenkron metod.
  Future<void> register(User user, String password) async {
    // Veritabanı servisinden kullanıcı ekleniyor.
    await DatabaseService().insertUser(user, password);
    notifyListeners(); // Dinleyicilere (listeners) veri değişikliği bildiriliyor.
  }

  // Kullanıcıyı silen asenkron metod.
  Future<void> deleteUser(String id) async {
    // Veritabanı servisinden kullanıcı siliniyor.
    await DatabaseService().deleteUser(id);
    notifyListeners(); // Dinleyicilere (listeners) veri değişikliği bildiriliyor.
  }

  // Tüm kullanıcıları döndüren asenkron metod.
  Future<List<User>> getAllUsers() async {
    // Veritabanı bağlantısı alınıyor.
    final db = await DatabaseService().database;
    // Veritabanından kullanıcılar çekiliyor.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Çekilen kullanıcılar User nesnelerine dönüştürülüp liste olarak döndürülüyor.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'], // Haritadaki 'id' değeri User nesnesine atanıyor.
        name: maps[i]
            ['name'], // Haritadaki 'name' değeri User nesnesine atanıyor.
        email: maps[i]
            ['email'], // Haritadaki 'email' değeri User nesnesine atanıyor.
        isAdmin: maps[i]['isAdmin'] ==
            1, // Haritadaki 'isAdmin' değeri boolean olarak User nesnesine atanıyor.
      );
    });
  }
}
