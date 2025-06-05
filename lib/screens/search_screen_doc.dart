import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/screens/filter_screen.dart';

class SearchScreenDoctor extends StatefulWidget {
  const SearchScreenDoctor({super.key});

  @override
  State<SearchScreenDoctor> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenDoctor> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    "Appointments on Dec 20, 2024",
    "Pending Appointments",
    "Search for Ahmed's Stroke Test Results",
  ];

  void _removeRecentSearch(int index) {
    setState(() {
      _recentSearches.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Search', style: TextStyle(color: AppColors.textColor)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty && !_recentSearches.contains(value)) {
                        setState(() {
                          _recentSearches.insert(0, value);
                          if (_recentSearches.length > 5) {
                            _recentSearches.removeLast();
                          }
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FilterScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.filter_list, color: AppColors.textColor),
                  ),
                )
              ],
            ),
          ),
          if (_recentSearches.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 12.0), // تعديل الـ padding
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Search',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: _recentSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_recentSearches[index], style: const TextStyle(fontSize: 15)),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey[500], size: 20),
                    onPressed: () => _removeRecentSearch(index),
                  ),
                  onTap: () {
                    _searchController.text = _recentSearches[index];
                    _searchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _searchController.text.length));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}