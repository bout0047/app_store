import 'package:flutter/material.dart';
import '../models/app_model.dart';

class PurchaseScreen extends StatelessWidget {
  final AppModel app;

  PurchaseScreen({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${app.name}'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle purchase logic
          },
          child: Text('Confirm Purchase'),
        ),
      ),
    );
  }
}
