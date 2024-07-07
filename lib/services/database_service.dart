import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/event_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bilecik_app.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, email TEXT, password TEXT, isAdmin INTEGER)",
        );
        await db.execute(
          "CREATE TABLE events(id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, imageUrl TEXT)",
        );

        // Admin kullanıcısını oluştur
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

  Future<void> insertUser(User user, String password) async {
    final db = await database;
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

  Future<void> insertEvent(Event event) async {
    final db = await database;
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

  Future<List<Event>> getEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events');

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

  Future<User?> getUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps.first['id'],
        name: maps.first['name'],
        email: maps.first['email'],
        isAdmin: maps.first['isAdmin'] == 1,
      );
    } else {
      return null;
    }
  }
}
