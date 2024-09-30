import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_store/services/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _apps;

  @override
  void initState() {
    super.initState();
    _apps = ApiService().fetchApps(); // Fetch the apps using ApiService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Store',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _apps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No apps found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var app = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/games.svg', // You can change this to use other icons too
                      height: 40.0,
                      width: 40.0,
                      color: Colors.blue, // You can customize the color
                    ),
                    title: Text(
                      app['name'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      app['description'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
