import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import '../models/event_model.dart';

class ApiService {
  final String _baseUrl = 'https://bilecik.gsb.gov.tr/HaberListesi/3/19';

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        return parseEventsFromHtml(response.body);
      } else {
        throw Exception('Etkinlikler yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Etkinlikler yüklenemedi: $e');
    }
  }

  List<Event> parseEventsFromHtml(String htmlBody) {
    var document = parse(htmlBody);
    var articles = document.querySelectorAll('.col-md-4 .post-slide8');
    List<Event> events = [];

    for (var article in articles) {
      var titleElement = article.querySelector('.post-title a');
      var dateElement = article.querySelector('.post-date');
      var descriptionElement = article.querySelector('.post-description');
      var imageElement = article.querySelector('img');

      if (titleElement != null &&
          dateElement != null &&
          descriptionElement != null &&
          imageElement != null) {
        String title = titleElement.text.trim();
        String date = dateElement.text.trim();
        String description = descriptionElement.text.trim();
        String imageUrl = imageElement.attributes['src'] ?? '';

        if (!imageUrl.startsWith('http')) {
          imageUrl = 'https://bilecik.gsb.gov.tr$imageUrl';
        }

        int id = articles.indexOf(article) + 1;

        Event event = Event(
          id: id,
          title: title,
          date: date,
          description: description,
          imageUrl: imageUrl,
        );

        events.add(event);
      }
    }
    return events;
  }
}
