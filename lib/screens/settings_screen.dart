// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

// SettingsScreen adında stateless bir widget sınıfı oluşturuluyor.
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Ayarlar' olarak ayarlanır.
        title: Text('Ayarlar'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, uygulama ayarları hakkında bilgi verir.
        child: Text('Uygulama ayarları burada yer alacak.'),
      ),
    );
  }
}
