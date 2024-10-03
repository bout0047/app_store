import 'package:flutter/material.dart';
import 'services/network_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Store',
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
  final NetworkService networkService = NetworkService();
  late Future<List<App>> _apps;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _apps = networkService.fetchApps(); // Initialize the API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Store'),
      ),
      body: Column(
        children: [
          // Banner using Picsum
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/800/150'), // Banner image from Picsum
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Welcome to the App Store!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black45,
                ),
              ),
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for apps...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // Future Builder for List of Apps
          Expanded(
            child: FutureBuilder<List<App>>(
              future: _apps,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Show a loading spinner while waiting for data
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}')); // Show error if the API call fails
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No apps available.')); // Show this if there is no data
                } else {
                  final apps = snapshot.data!
                      .where((app) => app.name.toLowerCase().contains(searchQuery) || app.description.toLowerCase().contains(searchQuery))
                      .toList(); // Filter apps based on search query

                  return ListView.builder(
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // App Icon
                              Image.network(
                                'https://picsum.photos/50/50?random=${app.id}', // Logo image from Picsum for each app
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),
                              // App Details
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
                                    SizedBox(height: 5),
                                    Text(
                                      app.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Install Button
                              ElevatedButton(
                                onPressed: () {
                                  // Mock "Install" action
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Installing ${app.name}...')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  backgroundColor: Colors.blueAccent, // Updated background color for a richer look
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30), // Make the button more rounded
                                  ),
                                  elevation: 8, // Add elevation to give a 3D effect
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.download, color: Colors.white),
                                    SizedBox(width: 5),
                                    Text(
                                      'Install',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
