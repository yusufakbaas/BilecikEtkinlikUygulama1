// Gerekli paketler import ediliyor.
import 'package:html/parser.dart'
    show parse; // HTML parsing için gerekli paket.
import 'package:http/http.dart' as http; // HTTP istekleri için gerekli paket.

import '../models/event_model.dart'; // Event modelini içeren dosya import ediliyor.

// ApiService sınıfı, web'den etkinlik verilerini almak için kullanılır.
class ApiService {
  // _baseUrl adında özel (private) bir değişken oluşturuluyor ve Bilecik etkinlikleri için URL atanıyor.
  final String _baseUrl = 'https://bilecik.gsb.gov.tr/HaberListesi/3/19';

  // Web'den etkinlikleri getiren asenkron metod.
  Future<List<Event>> fetchEvents() async {
    try {
      // Belirtilen URL'ye HTTP GET isteği gönderiliyor.
      final response = await http.get(Uri.parse(_baseUrl));

      // Eğer istek başarılıysa (status code 200)
      if (response.statusCode == 200) {
        // Gelen HTML yanıtı parseEventsFromHtml metodu ile işleniyor ve etkinlik listesi döndürülüyor.
        return parseEventsFromHtml(response.body);
      } else {
        // Başarısız olursa bir hata fırlatılıyor.
        throw Exception('Etkinlikler yüklenemedi: ${response.statusCode}');
      }
    } catch (e) {
      // Herhangi bir hata durumunda bir hata fırlatılıyor.
      throw Exception('Etkinlikler yüklenemedi: $e');
    }
  }

  // HTML içeriğinden etkinlikleri parse eden metod.
  List<Event> parseEventsFromHtml(String htmlBody) {
    // HTML içeriği parse ediliyor.
    var document = parse(htmlBody);
    // Etkinliklerin bulunduğu HTML elementleri seçiliyor.
    var articles = document.querySelectorAll('.col-md-4 .post-slide8');
    // Boş bir etkinlik listesi oluşturuluyor.
    List<Event> events = [];

    // Her bir etkinlik HTML elementi üzerinde döngü yapılıyor.
    for (var article in articles) {
      // Etkinlik başlığı, tarihi, açıklaması ve resmi elementleri seçiliyor.
      var titleElement = article.querySelector('.post-title a');
      var dateElement = article.querySelector('.post-date');
      var descriptionElement = article.querySelector('.post-description');
      var imageElement = article.querySelector('img');

      // Eğer tüm elementler mevcutsa
      if (titleElement != null &&
          dateElement != null &&
          descriptionElement != null &&
          imageElement != null) {
        // Elementlerin metin içerikleri alınıyor ve boşluklar temizleniyor.
        String title = titleElement.text.trim();
        String date = dateElement.text.trim();
        String description = descriptionElement.text.trim();
        String imageUrl = imageElement.attributes['src'] ?? '';

        // Resim URL'si tam değilse, tam URL oluşturuluyor.
        if (!imageUrl.startsWith('http')) {
          imageUrl = 'https://bilecik.gsb.gov.tr$imageUrl';
        }

        // Her etkinliğe benzersiz bir ID atanıyor.
        int id = articles.indexOf(article) + 1;

        // Yeni bir Event nesnesi oluşturuluyor.
        Event event = Event(
          id: id,
          title: title,
          date: date,
          description: description,
          imageUrl: imageUrl,
        );

        // Etkinlik listesine ekleniyor.
        events.add(event);
      }
    }
    // Tüm etkinlikler döndürülüyor.
    return events;
  }
}
