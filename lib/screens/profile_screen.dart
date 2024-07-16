// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart'; // UserProvider'ı içe aktarır

// ProfileScreen adında stateless bir widget sınıfı oluşturuluyor.
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserProvider'dan kullanıcı verilerini almak için Provider kullanılıyor.
    final user = Provider.of<UserProvider>(context).user;

    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      appBar: AppBar(
        // AppBar'ın başlığı, 'Profil Ayarları' olarak ayarlanır.
        title: Text('Profil Ayarları'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Center(
        // İçerik etrafında boşluk oluşturur.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Column widget'ı, çocuk widget'ları dikey olarak hizalar.
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Çocukları sola hizalar.
            children: <Widget>[
              // 'Profil Bilgileri' başlığını gösterir.
              Text(
                'Profil Bilgileri',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height:
                      16), // Başlık ile giriş alanı arasında boşluk bırakır.
              // Kullanıcı adı için metin alanı.
              TextField(
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı', // Giriş alanı etiketi.
                  border: OutlineInputBorder(), // Giriş alanı kenarlığı.
                ),
              ),
              SizedBox(height: 16), // Giriş alanları arasında boşluk bırakır.
              // Email için metin alanı.
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email', // Giriş alanı etiketi.
                  border: OutlineInputBorder(), // Giriş alanı kenarlığı.
                ),
              ),
              SizedBox(
                  height:
                      16), // Giriş alanları ve buton arasında boşluk bırakır.
              // Profil güncelleme butonu.
              ElevatedButton(
                onPressed: () {
                  // Profil güncelleme işlemi.
                },
                child: Text('Güncelle'), // Buton metni.
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Buton boyutu.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
