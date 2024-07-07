import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart'; // EventProvider'ı import ettik
import '../providers/user_provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menü'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Ana Sayfa'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Etkinlikler'),
            onTap: () {
              Navigator.pushNamed(context, '/eventList');
            },
          ),
          if (userProvider.user?.isAdmin == true) ...[
            ListTile(
              title: Text('Etkinlik Ekle'),
              onTap: () {
                Navigator.pushNamed(context, '/addEvent');
              },
            ),
            ListTile(
              title: Text('Web Sitesi Verisini Güncelle'),
              onTap: () {
                Provider.of<EventProvider>(context, listen: false)
                    .fetchEvents();
              },
            ),
            ListTile(
              title: Text('Kullanıcılar ve Bilgileri'),
              onTap: () {
                // Kullanıcılar ekranına yönlendirin
              },
            ),
          ],
          ListTile(
            title: Text('Profil Ayarları'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: Text('Çıkış Yap'),
            onTap: () {
              userProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
