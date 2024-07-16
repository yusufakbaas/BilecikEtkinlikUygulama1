// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart'; // Flutter'ın Material Design bileşenleri için gerekli paket.import '../models/event_model.dart'; // Event modelini içeren dosya import ediliyor.import '../services/api_service.dart'; // API servislerini içeren dosya import ediliyor.import '../services/database_service.dart'; // Veritabanı servislerini içeren dosya import ediliyor.

// EventProvider sınıfı, ChangeNotifier sınıfından türetiliyor.
// Bu sınıf, Flutter'ın state management (durum yönetimi) için kullanılan bir sınıftır.
class EventProvider with ChangeNotifier {
  // _events adında özel (private) bir liste oluşturuluyor ve Event nesnelerini tutuyor.
  List<Event> _events = [];

  // _events listesinin sadece okunabilir bir kopyasını döndüren getter metodu.
  List<Event> get events => _events;

  // Veritabanından etkinlikleri çeken ve _events listesine atayan asenkron metod.
  Future<void> fetchEvents() async {
    // Veritabanı servisinden etkinlikler çekiliyor.
    _events = await DatabaseService().getEvents();
    // Dinleyicilere (listeners) veri değişikliği bildiriliyor.
    notifyListeners();
  }

  // Yeni bir etkinliği veritabanına ekleyen ve _events listesine ekleyen asenkron metod.
  Future<void> addEvent(Event event) async {
    // Veritabanı servisinden etkinlik ekleniyor.
    await DatabaseService().insertEvent(event);
    // _events listesine yeni eklenen etkinlik ekleniyor.
    _events.add(event);
    // Dinleyicilere (listeners) veri değişikliği bildiriliyor.
    notifyListeners();
  }

  // Web'den etkinlikleri kazıyan (scrape) ve veritabanına ekleyen asenkron metod.
  Future<void> scrapeEvents() async {
    // ApiService sınıfından bir örnek oluşturuluyor.
    final apiService = ApiService();
    // Web'den etkinlikler çekiliyor.
    final scrapedEvents = await apiService.fetchEvents();
    // Çekilen etkinlikler döngüye alınıyor ve her bir etkinlik veritabanına ekleniyor.
    for (var event in scrapedEvents) {
      await addEvent(event); // Her etkinlik için addEvent metodu çağrılıyor.
    }
  }
}
