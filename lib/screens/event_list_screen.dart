// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import '../providers/event_provider.dart'; // EventProvider'ı içe aktarır

// EventListScreen, StatelessWidget'i genişleterek etkinlik listesini göstermek için bir ekran oluşturur
class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Etkinlikler'), // AppBar başlığı olarak 'Etkinlikler' yazılır
      ),
      body: FutureBuilder(
        // EventProvider kullanarak scrapeEvents() metodunu çağırır ve FutureBuilder ile sonuçları bekler
        future:
            Provider.of<EventProvider>(context, listen: false).scrapeEvents(),
        builder: (context, snapshot) {
          // Eğer Future hala bekleniyorsa, yükleme göstergesi gösterilir
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            // Eğer bir hata oluşmuşsa, hata mesajı gösterilir
          } else if (snapshot.error != null) {
            return Center(child: Text('Bir hata oluştu!'));
            // Eğer veriler başarıyla yüklenmişse, Consumer kullanarak EventProvider'dan verileri alır
          } else {
            return Consumer<EventProvider>(
              builder: (context, eventProvider, child) => ListView.builder(
                itemCount: eventProvider.events.length, // Etkinliklerin sayısı
                itemBuilder: (context, index) {
                  final event =
                      eventProvider.events[index]; // Her bir etkinliği alır
                  return GestureDetector(
                    onTap: () {
                      // Etkinliğe tıklandığında EventDetailScreen'e yönlendirilir
                      Navigator.pushNamed(
                        context,
                        '/eventDetail',
                        arguments: event, // Etkinlik verileri gönderilir
                      );
                    },
                    child: Card(
                      // Etkinlik bilgilerini içeren bir kart oluşturulur
                      child: ListTile(
                        leading: event.imageUrl.isNotEmpty
                            ? Image.network(
                                event.imageUrl) // Resim URL'si varsa gösterilir
                            : null, // Yoksa boş bırakılır
                        title: Text(event.title), // Etkinlik başlığı
                        subtitle: Text(
                            '${event.date}\n${event.description}'), // Etkinlik tarihi ve açıklaması
                        isThreeLine: true, // Üç satırlık alan ayrılır
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
