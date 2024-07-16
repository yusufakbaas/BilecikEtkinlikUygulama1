// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart'; // UserProvider'ı içe aktarır
import '../widgets/drawer_widget.dart'; // DrawerWidget'ı içe aktarır

// HomeScreen adında stateless bir widget sınıfı oluşturuluyor.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserProvider'dan kullanıcı verilerini almak için Provider kullanılıyor.
    final user = Provider.of<UserProvider>(context).user;

    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      appBar: AppBar(
        // AppBar'ın başlığı, 'Ana Sayfa' olarak ayarlanır.
        title: Text('Ana Sayfa'),
        actions: [
          // AppBar'da bir logout butonu eklenir.
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Butona basıldığında kullanıcı çıkış yapar ve giriş sayfasına yönlendirilir.
              Provider.of<UserProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      // Scaffold'un yan menüsü (drawer), DrawerWidget kullanılarak oluşturulur.
      drawer: DrawerWidget(),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Merkezi bir metin widget'ı, kullanıcıyı hoşgeldiniz mesajı ile karşılar.
        child: Text('Hoş geldiniz, ${user?.name}!'),
      ),
    );
  }
}
