import 'package:flutter/material.dart';

import '../models/event_model.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    _events = await DatabaseService().getEvents();
    notifyListeners();
  }

  Future<void> addEvent(Event event) async {
    await DatabaseService().insertEvent(event);
    _events.add(event);
    notifyListeners();
  }

  Future<void> scrapeEvents() async {
    final apiService = ApiService();
    final scrapedEvents = await apiService.fetchEvents();
    for (var event in scrapedEvents) {
      await addEvent(event);
    }
  }
}
