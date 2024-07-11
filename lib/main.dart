import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/event_provider.dart';
import 'providers/user_provider.dart';
import 'screens/add_event_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/event_list_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
        title: 'Bilecik Etkinlik Uygulaması',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/admin': (context) => AdminScreen(),
          '/register': (context) => RegisterScreen(),
          '/eventList': (context) => EventListScreen(),
          '/addEvent': (context) => AddEventScreen(),
          '/eventDetail': (context) => EventDetailScreen(),
        },
      ),
    );
  }
}
