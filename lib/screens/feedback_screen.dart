// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

// FeedbackScreen adında stateless bir widget sınıfı oluşturuluyor.
class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Geri Bildirim' olarak ayarlanır.
        title: Text('Geri Bildirim'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, geri bildirimler hakkında bilgi verir.
        child: Text('Geri bildirimlerinizi buraya yazabilirsiniz.'),
      ),
    );
  }
}
