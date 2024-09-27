import 'package:flutter/material.dart';
import 'package:app_store/models/app_model.dart';
import 'package:app_store/models/category_model.dart';
import 'package:app_store/services/api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();

  List<CategoryModel> categories = [];
  List<AppModel> apps = [];
  List<AppModel> popularApps = [];

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  void _getInitialInfo() async {
    categories = CategoryModel.getCategories(); // Get static categories
    apps = await _apiService.fetchApps(); // Fetch apps from API
    popularApps = await _apiService.fetchPopularApps(); // Fetch popular apps
    setState(() {}); // Update UI after fetching
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Store'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 40,),
          _categoriesSection(),
          const SizedBox(height: 40,),
          _appSection(),
          const SizedBox(height: 40,),
          _popularAppSection(),
          const SizedBox(height: 40,),
        ],
      ),
    );
  }

  // Search bar widget
  Widget _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search for apps',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Categories section
  Widget _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return CategoryItem(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }

  // Recommended apps section
  Widget _appSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommended Apps',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15,),
        apps.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: apps.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return AppItem(app: apps[index]);
            },
          ),
        ),
      ],
    );
  }

  // Popular apps section
  Widget _popularAppSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Popular Apps',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15,),
        popularApps.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: popularApps.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return PopularAppItem(app: popularApps[index]);
          },
        ),
      ],
    );
  }
}

// Category item widget
class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: category.boxColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(category.iconPath, height: 50),
          const SizedBox(height: 10),
          Text(category.name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// App item widget for recommended apps
class AppItem extends StatelessWidget {
  final AppModel app;

  const AppItem({required this.app});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(app.iconPath, height: 100),
          const SizedBox(height: 10),
          Text(app.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('${app.category} | ${app.rating} stars', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

// Popular app item widget
class PopularAppItem extends StatelessWidget {
  final AppModel app;

  const PopularAppItem({required this.app});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10, spreadRadius: 1),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(app.iconPath, height: 50),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(app.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('${app.category} | ${app.rating} stars', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},  // Handle download action here
          ),
        ],
      ),
    );
  }
}
