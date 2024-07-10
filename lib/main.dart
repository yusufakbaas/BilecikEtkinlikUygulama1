import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/event_provider.dart'; // EventProvider'ı import eder
import 'providers/user_provider.dart'; // UserProvider'ı import eder
import 'screens/add_event_screen.dart'; // AddEventScreen'i import eder
import 'screens/admin_screen.dart'; // AdminScreen'i import eder
import 'screens/event_detail_screen.dart'; // EventDetailScreen'i import eder
import 'screens/event_list_screen.dart'; // EventListScreen'i import eder
import 'screens/home_screen.dart'; // HomeScreen'i import eder
import 'screens/login_screen.dart'; // LoginScreen'i import eder
import 'screens/profile_screen.dart'; // ProfileScreen'i import eder
import 'screens/register_screen.dart'; // RegisterScreen'i import eder
import 'screens/welcome_screen.dart'; // WelcomeScreen'i import eder

void main() {
  runApp(MyApp());
}

// MyApp sınıfı, StatelessWidget'i genişleterek uygulamanın ana yapısını oluşturur
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Bilecik Etkinlik Uygulaması',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/addEvent': (context) => AddEventScreen(),
          '/eventList': (context) => EventListScreen(),
          '/admin': (context) => AdminScreen(),
          '/eventDetail': (context) => EventDetailScreen(), // Yeni rota eklendi
        },
      ),
    );
  }
}
