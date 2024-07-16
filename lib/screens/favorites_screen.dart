// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

// FavoritesScreen adında stateless bir widget sınıfı oluşturuluyor.
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Favoriler' olarak ayarlanır.
        title: Text('Favoriler'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, favori etkinlikler hakkında bilgi verir.
        child: Text('Favori etkinlikleriniz burada görünecek.'),
      ),
    );
  }
}
