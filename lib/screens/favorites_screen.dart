import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriler'),
      ),
      body: Center(
        child: Text('Favori etkinlikleriniz burada görünecek.'),
      ),
    );
  }
}
