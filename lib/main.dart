// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import 'providers/event_provider.dart'; // EventProvider'ı import ediyoruz.
import 'providers/user_provider.dart'; // UserProvider'ı import ediyoruz.
import 'screens/add_event_screen.dart'; // AddEventScreen'i import ediyoruz.
import 'screens/admin_screen.dart'; // AdminScreen'i import ediyoruz.
import 'screens/event_detail_screen.dart'; // EventDetailScreen'i import ediyoruz.
import 'screens/event_list_screen.dart'; // EventListScreen'i import ediyoruz.
import 'screens/home_screen.dart'; // HomeScreen'i import ediyoruz.
import 'screens/login_screen.dart'; // LoginScreen'i import ediyoruz.
import 'screens/register_screen.dart'; // RegisterScreen'i import ediyoruz.

// Uygulama giriş noktası.
void main() {
  runApp(MyApp()); // MyApp widget'ı çalıştırılıyor.
}

// MyApp adında stateless bir widget sınıfı oluşturuluyor.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Birden fazla provider kullanabilmek için MultiProvider widget'ı kullanılıyor.
      providers: [
        // UserProvider'ı ChangeNotifierProvider olarak tanımlıyoruz.
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // EventProvider'ı ChangeNotifierProvider olarak tanımlıyoruz.
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
        title: 'Bilecik Etkinlik Uygulaması', // Uygulama başlığı.
        theme: ThemeData(
          primarySwatch: Colors.blue, // Tema rengi olarak mavi belirleniyor.
        ),
        initialRoute: '/login', // Başlangıç rotası olarak /login belirleniyor.
        routes: {
          '/login': (context) =>
              LoginScreen(), // /login rotası LoginScreen'e yönlendiriliyor.
          '/home': (context) =>
              HomeScreen(), // /home rotası HomeScreen'e yönlendiriliyor.
          '/admin': (context) =>
              AdminScreen(), // /admin rotası AdminScreen'e yönlendiriliyor.
          '/register': (context) =>
              RegisterScreen(), // /register rotası RegisterScreen'e yönlendiriliyor.
          '/eventList': (context) =>
              EventListScreen(), // /eventList rotası EventListScreen'e yönlendiriliyor.
          '/addEvent': (context) =>
              AddEventScreen(), // /addEvent rotası AddEventScreen'e yönlendiriliyor.
          '/eventDetail': (context) =>
              EventDetailScreen(), // /eventDetail rotası EventDetailScreen'e yönlendiriliyor.
        },
      ),
    );
  }
}
