// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

// HelpScreen adında stateless bir widget sınıfı oluşturuluyor.
class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Yardım' olarak ayarlanır.
        title: Text('Yardım'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, yardım sayfası hakkında bilgi verir.
        child: Text('Yardım sayfası.'),
      ),
    );
  }
}
