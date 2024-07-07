import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';

class WebScrapingResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      appBar: AppBar(
        title: Text('Web Scraped Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: ListTile(
              leading: event.imageUrl.isNotEmpty
                  ? Image.network(event.imageUrl)
                  : null,
              title: Text(event.title),
              subtitle: Text('${event.date}\n${event.description}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
