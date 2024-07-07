import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import '../models/event_model.dart';

class WebScrapingService {
  final String url = 'https://bilecik.gsb.gov.tr/HaberListesi/3/19';

  Future<List<Event>> fetchEvents() async {
    List<Event> events = [];
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var document = parse(response.body);
      var articles = document.querySelectorAll('.col-md-4 .post-slide8');

      for (var article in articles) {
        var titleElement = article.querySelector('.post-title a');
        var dateElement = article.querySelector('.post-date');
        var descriptionElement = article.querySelector('.post-description');
        var imageElement = article.querySelector('.post-image img');

        if (titleElement != null &&
            dateElement != null &&
            descriptionElement != null &&
            imageElement != null) {
          String title = titleElement.text.trim();
          String date = dateElement.text.trim();
          String description = descriptionElement.text.trim();
          String imageUrl = imageElement.attributes['src']!;

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
    } else {
      print('Veri yüklenemedi');
    }
    return events;
  }
}
