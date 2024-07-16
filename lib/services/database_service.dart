// Gerekli paketler import ediliyor.
import 'dart:async'; // Asenkron programlama için gerekli paket.import 'package:path/path.dart'; // Dosya yollarını birleştirmek için gerekli paket.import 'package:sqflite/sqflite.dart'; // SQLite veritabanı için gerekli paket.

import '../models/event_model.dart'; // Event modelini içeren dosya import ediliyor.
import '../models/user_model.dart'; // User modelini içeren dosya import ediliyor.

// DatabaseService sınıfı, SQLite veritabanı ile ilgili işlemleri gerçekleştirmek için kullanılır.
class DatabaseService {
  // Özel (private) bir Database nesnesi oluşturuluyor.
  Database? _database;

  // Database getter metodu, veritabanı nesnesini döndürür veya başlatır.
  Future<Database> get database async {
    // Eğer veritabanı nesnesi mevcutsa onu döndürür.
    if (_database != null) return _database!;
    // Değilse, veritabanı başlatılır.
    _database = await _initDatabase();
    return _database!;
  }

  // Veritabanını başlatan metod.
  Future<Database> _initDatabase() async {
    // Veritabanı dosya yolu oluşturuluyor.
    String path = join(await getDatabasesPath(), 'bilecik_app.db');
    // Veritabanı açılıyor ve oluşturuluyor.
    return openDatabase(
      path,
      // Veritabanı oluşturulurken çağrılan onCreate fonksiyonu.
      onCreate: (db, version) async {
        // users tablosu oluşturuluyor.
        await db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, email TEXT, password TEXT, isAdmin INTEGER)",
        );
        // events tablosu oluşturuluyor.
        await db.execute(
          "CREATE TABLE events(id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, imageUrl TEXT)",
        );

        // Admin kullanıcısı oluşturuluyor.
        await db.insert(
          'users',
          {
            'id': '1',
            'name': 'Admin',
            'email': 'admin@example.com', // Admin email
            'password': 'admin123', // Admin password
            'isAdmin': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
      version: 1,
    );
  }

  // Yeni bir kullanıcı ekleyen asenkron metod.
  Future<void> insertUser(User user, String password) async {
    // Veritabanı nesnesi alınıyor.
    final db = await database;
    // users tablosuna yeni kullanıcı ekleniyor.
    await db.insert(
      'users',
      {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'password': password,
        'isAdmin': user.isAdmin ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Yeni bir etkinlik ekleyen asenkron metod.
  Future<void> insertEvent(Event event) async {
    // Veritabanı nesnesi alınıyor.
    final db = await database;
    // events tablosuna yeni etkinlik ekleniyor.
    await db.insert(
      'events',
      {
        'id': event.id,
        'title': event.title,
        'description': event.description,
        'date': event.date,
        'imageUrl': event.imageUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Tüm etkinlikleri döndüren asenkron metod.
  Future<List<Event>> getEvents() async {
    // Veritabanı nesnesi alınıyor.
    final db = await database;
    // events tablosundan tüm kayıtlar çekiliyor.
    final List<Map<String, dynamic>> maps = await db.query('events');

    // Çekilen kayıtlar Event nesnelerine dönüştürülüp liste olarak döndürülüyor.
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }

  // Belirtilen email ve şifreye sahip kullanıcıyı döndüren asenkron metod.
  Future<User?> getUser(String email, String password) async {
    // Veritabanı nesnesi alınıyor.
    final db = await database;
    // users tablosundan belirtilen email ve şifreye sahip kullanıcı çekiliyor.
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // Eğer kullanıcı bulunursa User nesnesine dönüştürülüp döndürülüyor.
    if (maps.isNotEmpty) {
      return User(
        id: maps.first['id'],
        name: maps.first['name'],
        email: maps.first['email'],
        isAdmin: maps.first['isAdmin'] == 1,
      );
    } else {
      // Eğer kullanıcı bulunmazsa null döndürülüyor.
      return null;
    }
  }

  // Belirtilen ID'ye sahip kullanıcıyı silen asenkron metod.
  Future<void> deleteUser(String id) async {
    // Veritabanı nesnesi alınıyor.
    final db = await database;
    // users tablosundan belirtilen ID'ye sahip kullanıcı siliniyor.
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
