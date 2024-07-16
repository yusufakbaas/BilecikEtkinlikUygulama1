// Gerekli paketler import ediliyor.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider paketi, state management için kullanılıyor.

import '../models/event_model.dart'; // Event modelini içeren dosya import ediliyor.
import '../providers/event_provider.dart'; // EventProvider sınıfını içeren dosya import ediliyor.

// AddEventScreen adında stateful bir widget sınıfı oluşturuluyor.
class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

// _AddEventScreenState adında state sınıfı oluşturuluyor.
class _AddEventScreenState extends State<AddEventScreen> {
  // TextEditingController nesneleri, metin alanları için kontrolörler oluşturuluyor.
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Scaffold widget'ı, ekranın temel yapısını oluşturur.
    return Scaffold(
      appBar: AppBar(
        // Uygulama çubuğunda başlık belirleniyor.
        title: Text('Etkinlik Ekle'),
      ),
      // Padding widget'ı, içerik etrafında boşluk oluşturur.
      body: Padding(
        padding: const EdgeInsets.all(16.0), // İçerik etrafındaki boşluk.
        // Column widget'ı, çocuk widget'ları dikey olarak hizalar.
        child: Column(
          children: <Widget>[
            // Başlık için metin alanı.
            TextField(
              controller: _titleController, // Başlık kontrolörü atanıyor.
              decoration:
                  InputDecoration(labelText: 'Başlık'), // Giriş alanı etiketi.
            ),
            // Açıklama için metin alanı.
            TextField(
              controller:
                  _descriptionController, // Açıklama kontrolörü atanıyor.
              decoration: InputDecoration(
                  labelText: 'Açıklama'), // Giriş alanı etiketi.
            ),
            // Tarih için metin alanı.
            TextField(
              controller: _dateController, // Tarih kontrolörü atanıyor.
              decoration:
                  InputDecoration(labelText: 'Tarih'), // Giriş alanı etiketi.
            ),
            // Görsel URL için metin alanı.
            TextField(
              controller:
                  _imageUrlController, // Görsel URL kontrolörü atanıyor.
              decoration: InputDecoration(
                  labelText: 'Görsel URL'), // Giriş alanı etiketi.
            ),
            SizedBox(height: 20), // İki widget arasında boşluk bırakılıyor.
            // Etkinlik ekleme butonu.
            ElevatedButton(
              onPressed: () {
                // Yeni bir etkinlik oluşturuluyor.
                final newEvent = Event(
                  id: DateTime.now()
                      .millisecondsSinceEpoch, // Benzersiz ID atanıyor.
                  title: _titleController.text, // Başlık atanıyor.
                  description:
                      _descriptionController.text, // Açıklama atanıyor.
                  date: _dateController.text, // Tarih atanıyor.
                  imageUrl: _imageUrlController.text, // Görsel URL atanıyor.
                );
                // EventProvider kullanılarak etkinlik ekleniyor.
                Provider.of<EventProvider>(context, listen: false)
                    .addEvent(newEvent);
                // Sayfa kapatılıyor ve önceki sayfaya dönülüyor.
                Navigator.pop(context);
              },
              child: Text('Ekle'), // Buton metni.
            ),
          ],
        ),
      ),
    );
  }
}
