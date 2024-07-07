import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geri Bildirim'),
      ),
      body: Center(
        child: Text('Geri bildirimlerinizi buraya yazabilirsiniz.'),
      ),
    );
  }
}
