import 'package:flutter/material.dart';
import '../models/app_model.dart';
import '../services/api_service.dart';

class AppListScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Store'),
      ),
      body: FutureBuilder<List<AppModel>>(
        future: apiService.fetchApps(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching apps'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No apps available'));
          } else {
            final apps = snapshot.data!;
            return ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(apps[index].name),
                  subtitle: Text(apps[index].description),
                  onTap: () {
                    // Navigate to AppDetailScreen
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
