import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/drawer_widget.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Paneli'),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                eventProvider.fetchEvents();
              },
              child: Text('Etkinlikleri Güncelle'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addEvent');
              },
              child: Text('Etkinlik Ekle'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Kullanıcılar ve bilgileri ekranına yönlendirme
              },
              child: Text('Kullanıcılar ve Bilgileri'),
            ),
          ],
        ),
      ),
    );
  }
}
