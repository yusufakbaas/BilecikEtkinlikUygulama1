// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart'; // Flutter'ın Material Design bileşenleri için gerekli paket.
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import '../models/user_model.dart'; // User modelini içeren dosya import ediliyor.
import '../providers/user_provider.dart'; // UserProvider sınıfını içeren dosya import ediliyor.

// ProfileSettings adında stateful bir widget sınıfı oluşturuluyor.
class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

// _ProfileSettingsState adında state sınıfı oluşturuluyor.
class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey =
      GlobalKey<FormState>(); // Form için global anahtar oluşturuluyor.
  late TextEditingController
      _usernameController; // Kullanıcı adı için kontrolör.
  late TextEditingController _emailController; // Email için kontrolör.

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _usernameController = TextEditingController(
        text: user?.name); // Kullanıcı adı kontrolörü başlatılıyor.
    _emailController = TextEditingController(
        text: user?.email); // Email kontrolörü başlatılıyor.
  }

  @override
  void dispose() {
    _usernameController
        .dispose(); // Kullanıcı adı kontrolörü serbest bırakılıyor.
    _emailController.dispose(); // Email kontrolörü serbest bırakılıyor.
    super.dispose();
  }

  void _updateProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Profil güncelleme işlemi
      Provider.of<UserProvider>(context, listen: false).updateProfile(
        User(
          id: Provider.of<UserProvider>(context, listen: false).user!.id,
          name: _usernameController.text,
          email: _emailController.text,
          isAdmin:
              Provider.of<UserProvider>(context, listen: false).user!.isAdmin,
        ),
      );

      // Profil başarıyla güncellendiği mesajı gösteriliyor.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil başarıyla güncellendi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Ayarları'), // AppBar başlığı.
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // İçerik etrafındaki boşluk.
          child: Form(
            key: _formKey, // Form anahtarı atanıyor.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Kolon hizalaması.
              children: <Widget>[
                Text(
                  'Profil Bilgileri',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold), // Başlık stili.
                ),
                SizedBox(height: 16), // Boşluk.
                TextFormField(
                  controller:
                      _usernameController, // Kullanıcı adı kontrolörü atanıyor.
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı', // Giriş alanı etiketi.
                    border: OutlineInputBorder(), // Giriş alanı kenarlığı.
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kullanıcı adı boş olamaz'; // Boşluk doğrulama mesajı.
                    }
                    return null; // Geçerli giriş.
                  },
                ),
                SizedBox(height: 16), // Boşluk.
                TextFormField(
                  controller: _emailController, // Email kontrolörü atanıyor.
                  decoration: InputDecoration(
                    labelText: 'Email', // Giriş alanı etiketi.
                    border: OutlineInputBorder(), // Giriş alanı kenarlığı.
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email boş olamaz'; // Boşluk doğrulama mesajı.
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Geçersiz email formatı'; // Geçersiz format doğrulama mesajı.
                    }
                    return null; // Geçerli giriş.
                  },
                ),
                SizedBox(height: 16), // Boşluk.
                ElevatedButton(
                  onPressed:
                      _updateProfile, // Buton basıldığında profil güncelleme işlemi.
                  child: Text('Güncelle'), // Buton metni.
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Buton boyutu.
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
