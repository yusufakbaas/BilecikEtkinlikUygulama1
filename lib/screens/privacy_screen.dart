// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

// PrivacyScreen adında stateless bir widget sınıfı oluşturuluyor.
class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Gizlilik Politikası' olarak ayarlanır.
        title: Text('Gizlilik Politikası'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, gizlilik politikası hakkında bilgi verir.
        child: Text('Gizlilik politikası burada yer alacak.'),
      ),
    );
  }
}
