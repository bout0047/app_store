import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/app_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Store Prototype',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppListScreen(),
    );
  }
}

class AppListScreen extends StatefulWidget {
  @override
  _AppListScreenState createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
  late Future<List<AppModel>> futureApps;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureApps = apiService.fetchApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Store'),
      ),
      body: FutureBuilder<List<AppModel>>(
        future: futureApps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final app = snapshot.data![index];
                return ListTile(
                  title: Text(app.name),
                  subtitle: Text('${app.description} (Category: ${app.categoryName})'),
                );
              },
            );
          } else {
            return Center(child: Text('No apps available.'));
          }
        },
      ),
    );
  }
}
