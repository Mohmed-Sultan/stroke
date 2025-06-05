import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> recentSearches = [
    'Neurologist Dr. Mohamed Ahmed',
    'Stroke Specialist - Egypt',
    'Consultations with Dr. Mohamed Ahmed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(child: Text('Search', style: TextStyle(color: Colors.black)),)
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: MyColors.mainColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recent Search',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                  color: MyColors.mainColor),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recentSearches[index]),
                    trailing: Icon(Icons.highlight_remove, color: Colors.grey),
                    onTap: () {
                      setState(() {
                        recentSearches.remove(recentSearches[index]);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
