import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import '../providers/event_provider.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlik Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Başlık'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Açıklama'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Tarih'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Görsel URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newEvent = Event(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: _dateController.text,
                  imageUrl: _imageUrlController.text,
                );
                Provider.of<EventProvider>(context, listen: false)
                    .addEvent(newEvent);
                Navigator.pop(context);
              },
              child: Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
