import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class GuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Misafir Girişi'),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Text('Misafir Girişi ile uygulamaya hoş geldiniz!'),
      ),
    );
  }
}
