// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import '../providers/event_provider.dart'; // EventProvider sınıfını içeren dosya import ediliyor.
import '../providers/user_provider.dart'; // UserProvider sınıfını içeren dosya import ediliyor.
import '../widgets/drawer_widget.dart'; // DrawerWidget'ı içeren dosya import ediliyor.

// AdminScreen adında stateless bir widget sınıfı oluşturuluyor.
class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // EventProvider ve UserProvider'dan veriler alınarak yerel değişkenlere atanıyor.
    final eventProvider = Provider.of<EventProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    // Scaffold widget'ı, ekranın temel yapısını oluşturur.
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Paneli'), // Uygulama çubuğunda başlık belirleniyor.
      ),
      drawer: DrawerWidget(), // Yan menü olarak DrawerWidget kullanılıyor.
      body: Padding(
        padding: const EdgeInsets.all(16.0), // İçerik etrafındaki boşluk.
        child: Column(
          children: <Widget>[
            // Etkinlikleri Güncelle butonu.
            ElevatedButton(
              onPressed: () {
                eventProvider
                    .fetchEvents(); // Butona basıldığında etkinlikler güncelleniyor.
              },
              child: Text('Etkinlikleri Güncelle'),
            ),
            // Etkinlik Ekle butonu.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context,
                    '/addEvent'); // Butona basıldığında Etkinlik Ekle sayfasına yönlendiriliyor.
              },
              child: Text('Etkinlik Ekle'),
            ),
            SizedBox(height: 16), // İki widget arasında boşluk bırakılıyor.
            // Kullanıcılar ve Bilgileri butonu.
            ElevatedButton(
              onPressed: () {
                // Butona basıldığında Kullanıcılar ve bilgileri ekranına yönlendiriliyor.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen()),
                );
              },
              child: Text('Kullanıcılar ve Bilgileri'),
            ),
            SizedBox(height: 16), // İki widget arasında boşluk bırakılıyor.
            // Kullanıcı listesi FutureBuilder ile yükleniyor.
            Expanded(
              child: FutureBuilder<List<User>>(
                future: userProvider.getAllUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Veri yüklenirken yükleme göstergesi.
                  }
                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length, // Kullanıcı sayısı.
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user.name), // Kullanıcı adı.
                        subtitle: Text(user.email), // Kullanıcı emaili.
                        trailing: IconButton(
                          icon: Icon(Icons.delete), // Silme ikonu.
                          onPressed: () async {
                            await userProvider
                                .deleteUser(user.id); // Kullanıcı siliniyor.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Kullanıcı silindi')), // Silme bildirimi.
                            );
                            // Sayfayı yeniden yüklemek için.
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        AdminScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// UserListScreen adında stateless bir widget sınıfı oluşturuluyor.
class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Scaffold widget'ı, ekranın temel yapısını oluşturur.
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Kullanıcı Listesi'), // Uygulama çubuğunda başlık belirleniyor.
      ),
      body: FutureBuilder<List<User>>(
        future: userProvider.getAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child:
                    CircularProgressIndicator()); // Veri yüklenirken yükleme göstergesi.
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length, // Kullanıcı sayısı.
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name), // Kullanıcı adı.
                subtitle: Text(user.email), // Kullanıcı emaili.
                trailing: IconButton(
                  icon: Icon(Icons.delete), // Silme ikonu.
                  onPressed: () async {
                    await userProvider
                        .deleteUser(user.id); // Kullanıcı siliniyor.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Kullanıcı silindi')), // Silme bildirimi.
                    );
                    // Sayfayı yeniden yüklemek için.
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            UserListScreen(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
