// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart'; // Flutter'ın Material Design bileşenleri için gerekli paket.

// AboutScreen adında stateless bir widget sınıfı oluşturuluyor.
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını oluşturur.
    return Scaffold(
      appBar: AppBar(
        // Uygulama çubuğunda başlık belirleniyor.
        title: Text('Hakkında'),
      ),
      body: Center(
        // Gövde kısmında merkezi bir metin widget'ı yerleştiriliyor.
        child: Text('Bu uygulama Bilecik etkinliklerini gösterir.'),
      ),
    );
  }
}
