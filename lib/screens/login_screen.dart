// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart'; // UserProvider'ı içe aktarır

// LoginScreen adında stateful bir widget sınıfı oluşturuluyor.
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// _LoginScreenState adında state sınıfı oluşturuluyor.
class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController nesneleri, metin alanları için kontrolörler oluşturuluyor.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      appBar: AppBar(
        // AppBar'ın başlığı, 'Giriş Yap' olarak ayarlanır.
        title: Text('Giriş Yap'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Padding(
        // Ekranın kenarlarına iç dolgu (padding) ekler
        padding: const EdgeInsets.all(16.0),
        // Column widget'ı, çocuk widget'ları dikey olarak hizalar
        child: Column(
          children: <Widget>[
            // Email için metin alanı
            TextField(
              controller: _emailController, // Email kontrolörü atanıyor
              decoration:
                  InputDecoration(labelText: 'Email'), // Giriş alanı etiketi
            ),
            // Şifre için metin alanı
            TextField(
              controller: _passwordController, // Şifre kontrolörü atanıyor
              decoration:
                  InputDecoration(labelText: 'Şifre'), // Giriş alanı etiketi
              obscureText: true, // Şifreyi gizli gösterir
            ),
            SizedBox(height: 20), // İki widget arasında boşluk bırakılıyor
            // Giriş yap butonu
            ElevatedButton(
              onPressed: () async {
                // Kullanıcı giriş işlemi
                bool success =
                    await Provider.of<UserProvider>(context, listen: false)
                        .login(_emailController.text, _passwordController.text);
                if (success) {
                  // Giriş başarılı ise ana sayfaya yönlendirme
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Giriş başarısız ise hata mesajı gösterme
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Giriş başarısız.')),
                  );
                }
              },
              child: Text('Giriş Yap'), // Buton metni
            ),
          ],
        ),
      ),
    );
  }
}
