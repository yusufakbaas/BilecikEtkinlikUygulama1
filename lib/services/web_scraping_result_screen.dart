// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart'; // Flutter'ın Material Design bileşenleri için gerekli paket.
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import '../providers/event_provider.dart'; // EventProvider sınıfını içeren dosya import ediliyor.

// WebScrapingResultScreen adında stateless bir widget sınıfı oluşturuluyor.
class WebScrapingResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // EventProvider'dan etkinlik verilerini almak için Provider kullanılıyor.
    final events = Provider.of<EventProvider>(context).events;

    // Scaffold widget'ı, ekranın temel yapısını oluşturur.
    return Scaffold(
      appBar: AppBar(
        // Uygulama çubuğunda başlık belirleniyor.
        title: Text('Web Scraped Events'),
      ),
      // Gövde kısmında ListView.builder kullanılarak dinamik bir liste oluşturuluyor.
      body: ListView.builder(
        // Listede kaç tane öğe olduğunu belirtiyor.
        itemCount: events.length,
        // Listedeki her bir öğenin nasıl görüneceğini tanımlıyor.
        itemBuilder: (context, index) {
          // Belirli bir etkinliği almak için index kullanılıyor.
          final event = events[index];
          // Her bir etkinlik için Card widget'ı oluşturuluyor.
          return Card(
            // Kart içeriği ListTile ile düzenleniyor.
            child: ListTile(
              // Etkinlik resmini göstermek için leading kısmı kullanılıyor.
              leading: event.imageUrl.isNotEmpty
                  ? Image.network(event
                      .imageUrl) // Eğer resim URL'si boş değilse, resmi göster.
                  : null, // Eğer resim URL'si boşsa, hiçbir şey gösterme.
              // Etkinlik başlığı title kısmında gösteriliyor.
              title: Text(event.title),
              // Etkinlik tarihi ve açıklaması subtitle kısmında gösteriliyor.
              subtitle: Text('${event.date}\n${event.description}'),
              // ListTile'ın üç satırlık olduğunu belirtiyor.
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
