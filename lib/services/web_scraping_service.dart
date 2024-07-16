// Gerekli paketler import ediliyor.
import 'package:html/parser.dart'
    show parse; // HTML parsing için gerekli paket.
import 'package:http/http.dart' as http; // HTTP istekleri için gerekli paket.

import '../models/event_model.dart'; // Event modelini içeren dosya import ediliyor.

// WebScrapingService sınıfı, web'den etkinlik verilerini almak için kullanılır.
class WebScrapingService {
  // Bilecik etkinlikleri için URL atanıyor.
  final String url = 'https://bilecik.gsb.gov.tr/HaberListesi/3/19';

  // Web'den etkinlikleri getiren asenkron metod.
  Future<List<Event>> fetchEvents() async {
    // Boş bir etkinlik listesi oluşturuluyor.
    List<Event> events = [];
    // Belirtilen URL'ye HTTP GET isteği gönderiliyor.
    final response = await http.get(Uri.parse(url));

    // Eğer istek başarılıysa (status code 200)
    if (response.statusCode == 200) {
      // Gelen HTML yanıtı parse ediliyor.
      var document = parse(response.body);
      // Etkinliklerin bulunduğu HTML elementleri seçiliyor.
      var articles = document.querySelectorAll('.col-md-4 .post-slide8');

      // Her bir etkinlik HTML elementi üzerinde döngü yapılıyor.
      for (var article in articles) {
        // Etkinlik başlığı, tarihi, açıklaması ve resmi elementleri seçiliyor.
        var titleElement = article.querySelector('.post-title a');
        var dateElement = article.querySelector('.post-date');
        var descriptionElement = article.querySelector('.post-description');
        var imageElement = article.querySelector('.post-image img');

        // Eğer tüm elementler mevcutsa
        if (titleElement != null &&
            dateElement != null &&
            descriptionElement != null &&
            imageElement != null) {
          // Elementlerin metin içerikleri alınıyor ve boşluklar temizleniyor.
          String title = titleElement.text.trim();
          String date = dateElement.text.trim();
          String description = descriptionElement.text.trim();
          String imageUrl = imageElement.attributes['src']!;

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
    } else {
      // Başarısız olursa hata mesajı yazdırılıyor.
      print('Veri yüklenemedi');
    }
    // Tüm etkinlikler döndürülüyor.
    return events;
  }
}
