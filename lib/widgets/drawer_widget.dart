// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart'; // Flutter'ın Material Design bileşenleri için gerekli paket.
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import '../providers/event_provider.dart'; // EventProvider'ı import ettik.
import '../providers/user_provider.dart'; // UserProvider'ı import ettik.

// DrawerWidget adında stateless bir widget sınıfı oluşturuluyor.
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // UserProvider'dan kullanıcı bilgilerini almak için Provider kullanılıyor.
    final userProvider = Provider.of<UserProvider>(context);

    // Drawer widget'ı, yan menünün temel yapısını oluşturur.
    return Drawer(
      child: ListView(
        // ListView padding sıfırlanıyor.
        padding: EdgeInsets.zero,
        // Menü öğeleri bir liste halinde oluşturuluyor.
        children: <Widget>[
          // DrawerHeader widget'ı, menünün üst kısmındaki başlığı temsil eder.
          DrawerHeader(
            child: Text('Menü'), // Başlık olarak 'Menü' yazılıyor.
            decoration: BoxDecoration(
              color: Colors
                  .blue, // Başlık arka plan rengi mavi olarak ayarlanıyor.
            ),
          ),
          // Ana Sayfa menü öğesi.
          ListTile(
            title: Text('Ana Sayfa'), // Menü öğesi başlığı.
            onTap: () {
              // Tıklandığında /home rotasına yönlendiriliyor.
              Navigator.pushNamed(context, '/home');
            },
          ),
          // Etkinlikler menü öğesi.
          ListTile(
            title: Text('Etkinlikler'), // Menü öğesi başlığı.
            onTap: () {
              // Tıklandığında /eventList rotasına yönlendiriliyor.
              Navigator.pushNamed(context, '/eventList');
            },
          ),
          // Kullanıcı yönetici ise gösterilecek menü öğeleri.
          if (userProvider.user?.isAdmin == true) ...[
            // Etkinlik Ekle menü öğesi.
            ListTile(
              title: Text('Etkinlik Ekle'), // Menü öğesi başlığı.
              onTap: () {
                // Tıklandığında /addEvent rotasına yönlendiriliyor.
                Navigator.pushNamed(context, '/addEvent');
              },
            ),
            // Web Sitesi Verisini Güncelle menü öğesi.
            ListTile(
              title:
                  Text('Web Sitesi Verisini Güncelle'), // Menü öğesi başlığı.
              onTap: () {
                // Tıklandığında etkinlikler güncelleniyor.
                Provider.of<EventProvider>(context, listen: false)
                    .fetchEvents();
              },
            ),
            // Kullanıcılar ve Bilgileri menü öğesi.
            ListTile(
              title: Text('Kullanıcılar ve Bilgileri'), // Menü öğesi başlığı.
              onTap: () {
                // Tıklandığında kullanıcılar ekranına yönlendiriliyor (şu anda işlevsiz).
              },
            ),
          ],
          // Profil Ayarları menü öğesi.
          ListTile(
            title: Text('Profil Ayarları'), // Menü öğesi başlığı.
            onTap: () {
              // Tıklandığında /profile rotasına yönlendiriliyor.
              Navigator.pushNamed(context, '/profile');
            },
          ),
          // Çıkış Yap menü öğesi.
          ListTile(
            title: Text('Çıkış Yap'), // Menü öğesi başlığı.
            onTap: () {
              // Tıklandığında kullanıcı çıkış yapılıyor ve /login rotasına yönlendiriliyor.
              userProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
