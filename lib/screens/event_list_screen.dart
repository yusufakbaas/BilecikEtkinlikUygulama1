import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';

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
                  return Card(
                    child: ListTile(
                      leading: Image.network(event.imageUrl),
                      title: Text(event.title),
                      subtitle: Text('${event.date}\n${event.description}'),
                      isThreeLine: true,
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
