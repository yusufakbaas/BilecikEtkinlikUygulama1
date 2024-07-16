// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart'; // User model sınıfını içe aktarır
import '../providers/user_provider.dart'; // UserProvider'ı içe aktarır

// RegisterScreen adında stateful bir widget sınıfı oluşturuluyor.
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

// _RegisterScreenState adında state sınıfı oluşturuluyor.
class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingController nesneleri, metin alanları için kontrolörler oluşturuluyor.
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını sağlar.
    return Scaffold(
      appBar: AppBar(
        // AppBar'ın başlığı, 'Kayıt Ol' olarak ayarlanır.
        title: Text('Kayıt Ol'),
      ),
      // Scaffold'un gövdesi (body), ekranın ana içeriğini içerir.
      body: Padding(
        // Ekranın kenarlarına iç dolgu (padding) ekler
        padding: const EdgeInsets.all(16.0),
        // Column widget'ı, çocuk widget'ları dikey olarak hizalar
        child: Column(
          children: <Widget>[
            // İsim için metin alanı
            TextField(
              controller: _nameController, // İsim kontrolörü atanıyor
              decoration:
                  InputDecoration(labelText: 'İsim'), // Giriş alanı etiketi
            ),
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
            // Kayıt ol butonu
            ElevatedButton(
              onPressed: () async {
                // Yeni kullanıcı oluşturma işlemi
                final newUser = User(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _nameController.text,
                  email: _emailController.text,
                  isAdmin: false,
                );
                // Kullanıcı kaydı yapılır
                await Provider.of<UserProvider>(context, listen: false)
                    .register(newUser, _passwordController.text);
                // Kayıt başarılı olursa giriş sayfasına yönlendirilir
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Kayıt Ol'), // Buton metni
            ),
          ],
        ),
      ),
    );
  }
}
