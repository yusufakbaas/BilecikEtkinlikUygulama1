import 'package:flutter/material.dart';

import '../models/event_model.dart'; // Event model sınıfını içe aktarır

// EventDetailScreen, StatelessWidget'i genişleterek bir etkinliğin detaylarını göstermek için bir ekran oluşturur
class EventDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ModalRoute üzerinden etkinlik (Event) verisini alır
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;

    // Scaffold, temel bir ekran yapısı sağlar
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir
      appBar: AppBar(
        // AppBar'ın başlığı, etkinliğin başlığı olarak ayarlanır
        title: Text(event.title),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir
      body: Padding(
        // Ekranın kenarlarına iç dolgu (padding) ekler
        padding: const EdgeInsets.all(16.0),
        // Column widget'ı, çocuk widget'ları dikey olarak hizalar
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Çocukları sola hizalar
          children: <Widget>[
            // Eğer imageUrl boş değilse, resim gösterir
            if (event.imageUrl.isNotEmpty)
              Image.network(
                event.imageUrl, // Resim URL'si
                fit: BoxFit.cover, // Resmi kaplayacak şekilde ayarlar
                width: double.infinity, // Genişliği tam ekran yapar
                height: 200, // Yüksekliği 200 piksel yapar
              ),
            SizedBox(height: 16), // Resim ile başlık arasında boşluk ekler
            // Etkinliğin başlığını gösteren Text widget'ı
            Text(
              event.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Başlık ile tarih arasında boşluk ekler
            // Etkinliğin tarihini gösteren Text widget'ı
            Text(
              event.date,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16), // Tarih ile açıklama arasında boşluk ekler
            // Etkinliğin açıklamasını gösteren Text widget'ı
            Text(event.description),
          ],
        ),
      ),
    );
  }
}
