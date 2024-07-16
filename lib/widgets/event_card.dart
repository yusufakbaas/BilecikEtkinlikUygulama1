// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

import '../models/event_model.dart'; // Event modelini içeren dosya import ediliyor.

// EventCard adında stateless bir widget sınıfı oluşturuluyor.
class EventCard extends StatelessWidget {
  // Event nesnesi, EventCard widget'ına parametre olarak aktarılıyor.
  final Event event;

  // EventCard kurucusu, event parametresini zorunlu kılıyor.
  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    // Card widget'ı oluşturuluyor.
    return Card(
      margin: EdgeInsets.all(8.0), // Kartın dış marjini ayarlanıyor.
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Kartın iç dolgusu ayarlanıyor.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Kolonun hizalaması sola ayarlanıyor.
          children: <Widget>[
            // Eğer etkinliğin resim URL'si boş değilse, resim gösteriliyor.
            if (event.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    8.0), // Resmin kenarları yuvarlatılıyor.
                child: Image.network(
                  event.imageUrl, // Resim URL'si ile resim gösteriliyor.
                  fit: BoxFit
                      .cover, // Resim, alanı kaplayacak şekilde ölçekleniyor.
                  width: double
                      .infinity, // Resim genişliği, maksimum genişlikte ayarlanıyor.
                  height: 150, // Resim yüksekliği 150 olarak ayarlanıyor.
                  // Resim yüklenirken bir yükleme göstergesi gösteriliyor.
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null)
                      return child; // Eğer yükleme tamamlandıysa, resmi göster.
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ??
                                    1) // Yükleme yüzdesi hesaplanıyor.
                            : null,
                      ),
                    );
                  },
                  // Resim yüklenirken bir hata oluşursa, yerel bir placeholder görseli gösteriliyor.
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/placeholder_image.png', // Yerel bir placeholder görseli.
                      fit: BoxFit
                          .cover, // Placeholder görseli, alanı kaplayacak şekilde ölçekleniyor.
                      width: double
                          .infinity, // Placeholder genişliği, maksimum genişlikte ayarlanıyor.
                      height:
                          150, // Placeholder yüksekliği 150 olarak ayarlanıyor.
                    );
                  },
                ),
              ),
            SizedBox(height: 8.0), // İki widget arasında boşluk bırakılıyor.
            Text(
              event.title, // Etkinlik başlığı gösteriliyor.
              style: TextStyle(
                fontSize: 18, // Metin boyutu ayarlanıyor.
                fontWeight: FontWeight.bold, // Metin kalın yapılıyor.
              ),
            ),
            SizedBox(height: 4.0), // İki widget arasında boşluk bırakılıyor.
            Text(
              event.date, // Etkinlik tarihi gösteriliyor.
              style: TextStyle(
                color: Colors.grey, // Metin rengi gri olarak ayarlanıyor.
              ),
            ),
            SizedBox(height: 4.0), // İki widget arasında boşluk bırakılıyor.
            Text(
              event.description, // Etkinlik açıklaması gösteriliyor.
              maxLines:
                  2, // Açıklama metni en fazla iki satır olarak gösteriliyor.
              overflow: TextOverflow
                  .ellipsis, // Açıklama metni taşarsa, üç nokta ile kesiliyor.
            ),
          ],
        ),
      ),
    );
  }
}
