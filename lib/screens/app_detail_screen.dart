import 'package:flutter/material.dart';
import '../models/app_model.dart';

class AppDetailScreen extends StatelessWidget {
  final AppModel app;

  AppDetailScreen({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(app.name, style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text(app.description),
            SizedBox(height: 20),
            Text('Price: \$${app.price}', style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () {
                // Handle app purchase
              },
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
