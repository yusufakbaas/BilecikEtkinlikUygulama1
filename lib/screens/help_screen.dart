import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yardım'),
      ),
      body: Center(
        child: Text('Yardım sayfası.'),
      ),
    );
  }
}
