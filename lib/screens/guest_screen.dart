// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart'; // DrawerWidget'ı içe aktarır

// GuestScreen adında stateless bir widget sınıfı oluşturuluyor.
class GuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Misafir Girişi' olarak ayarlanır.
        title: Text('Misafir Girişi'),
      ),
      // Scaffold'un yan menüsü (drawer), DrawerWidget kullanılarak oluşturulur.
      drawer: DrawerWidget(),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, misafir girişi hakkında bilgi verir.
        child: Text('Misafir Girişi ile uygulamaya hoş geldiniz!'),
      ),
    );
  }
}
