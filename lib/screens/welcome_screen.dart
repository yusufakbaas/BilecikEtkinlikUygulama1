// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';

// WelcomeScreen adında stateless bir widget sınıfı oluşturuluyor.
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      // Uygulama çubuğu (AppBar), ekranın üst kısmında bir başlık ve diğer öğeleri içerir.
      appBar: AppBar(
        // AppBar'ın başlığı, 'Hoş Geldiniz' olarak ayarlanır.
        title: Text('Hoş Geldiniz'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // Column widget'ı, çocuk widget'ları dikey olarak hizalar.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Çocukları ortalar.
          children: <Widget>[
            // Giriş Yap butonu
            ElevatedButton(
              onPressed: () {
                // Butona basıldığında /login rotasına yönlendirir.
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Giriş Yap'), // Buton metni
            ),
            // Kayıt Ol butonu
            ElevatedButton(
              onPressed: () {
                // Butona basıldığında /register rotasına yönlendirir.
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Kayıt Ol'), // Buton metni
            ),
            // Misafir Girişi butonu
            ElevatedButton(
              onPressed: () {
                // Butona basıldığında /guest rotasına yönlendirir.
                Navigator.pushNamed(context, '/guest');
              },
              child: Text('Misafir Girişi'), // Buton metni
            ),
          ],
        ),
      ),
    );
  }
}
