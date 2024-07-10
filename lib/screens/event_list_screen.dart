import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart'; // EventProvider'ı içe aktarır

// EventListScreen, StatelessWidget'i genişleterek etkinlik listesini göstermek için bir ekran oluşturur
class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlikler'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<EventProvider>(context, listen: false).scrapeEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Bir hata oluştu!'));
          } else {
            return Consumer<EventProvider>(
              builder: (context, eventProvider, child) => ListView.builder(
                itemCount: eventProvider.events.length,
                itemBuilder: (context, index) {
                  final event = eventProvider.events[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/eventDetail',
                        arguments: event,
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: event.imageUrl.isNotEmpty
                            ? Image.network(event.imageUrl)
                            : null,
                        title: Text(event.title),
                        subtitle: Text('${event.date}\n${event.description}'),
                        isThreeLine: true,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
