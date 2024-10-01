import 'package:flutter/material.dart';
import 'package:app_store/api_service.dart';
import 'package:app_store/models/app.dart';

void main() {
  runApp(AppStore());
}

class AppStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<AppModel>> _futureApps;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _futureApps = ApiService().fetchApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Store'),
      ),
      body: Column(
        children: [
          // Banner Section
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/800/150'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for apps...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Popular Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Popular Apps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // List of Apps
          Expanded(
            child: FutureBuilder<List<AppModel>>(
              future: _futureApps,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<AppModel> apps = snapshot.data!
                      .where((app) =>
                          app.name.toLowerCase().contains(_searchText.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      return AppCard(app: apps[index]);
                    },
                  );
                } else {
                  return Center(child: Text('No apps available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final AppModel app;

  AppCard({required this.app});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // App Logo using Picsum Image with unique URL for each app
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://picsum.photos/100?app=${app.id}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    app.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    app.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Install'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder classes for ApiService and AppModel
// These should be replaced with the real implementations based on your backend API response.

class ApiService {
  Future<List<AppModel>> fetchApps() async {
    // Simulate a network request
    await Future.delayed(Duration(seconds: 2));
    return [
      AppModel(id: 1, name: "Game One", description: "An exciting game."),
      AppModel(id: 2, name: "Productivity App", description: "Boost your productivity."),
    ];
  }
}

class AppModel {
  final int id;
  final String name;
  final String description;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
  });
}
