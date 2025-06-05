import 'package:flutter/material.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [
    "Appointments on Dec 20, 2024",
    "Pending Appointments",
    "Search for Ahmed's Stroke Test Results"
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // يمكنك هنا إضافة وظيفة الرجوع
          },
        ),
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Search',
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Colors.teal),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FilterScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Recent Search',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(recentSearches[index])),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              recentSearches.removeAt(index);
                            });
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedGender;
  String? selectedAgeGroup;
  String? selectedAppointmentDate;
  String? selectedAppointmentStatus;
  get s => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Filtration'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient\'s Gender',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              children: [
                _buildFilterButton('Male', selectedGender == 'Male', () {
                  setState(() {
                    selectedGender = 'Male';
                  });
                }),
                _buildFilterButton('Female', selectedGender == 'Female', () {
                  setState(() {
                    selectedGender = 'Female';
                  });
                }),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Patient\'s Age',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              children: [
                _buildFilterButton('Under 30 years',
                    selectedAgeGroup == 'Under 30 years', () {
                      setState(() {
                        selectedAgeGroup = 'Under 30 years';
                      });
                    }),
                _buildFilterButton('30-50 years',
                    selectedAgeGroup == '30-50 years', () {
                      setState(() {
                        selectedAgeGroup = '30-50 years';
                      });
                    }),
                _buildFilterButton('Above 40 years',
                    selectedAgeGroup == 'Above 40 years', () {
                      setState(() {
                        selectedAgeGroup = 'Above 40 years';
                      });
                    }),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Appointments',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              children: [
                _buildFilterButton('Today', selectedAppointmentDate == 'Today',
                        () {
                      setState(() {
                        selectedAppointmentDate = 'Today';
                      });
                    }),
                _buildFilterButton('This Week',
                    selectedAppointmentDate == 'This Week', () {
                      setState(() {
                        selectedAppointmentDate = 'This Week';
                      });
                    }),
                _buildFilterButton('Next Week',
                    selectedAppointmentDate == 'Next Week', () {
                      setState(() {
                        selectedAppointmentDate = 'Next Week';
                      });
                    }),
                _buildFilterButton('This Month',
                    selectedAppointmentDate == 'This Month', () {
                      setState(() {
                        selectedAppointmentDate = 'This Month';
                      });
                    }),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Appointment\'s Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              children: [
                _buildFilterButton('Pending', selectedAppointmentStatus == 'Pending',
                        () {
                      setState(() {
                        selectedAppointmentStatus = 'Pending';
                      });
                    }),
                _buildFilterButton('Confirmed',
                    selectedAppointmentStatus == 'Confirmed', () {
                      setState(() {
                        selectedAppointmentStatus = 'Confirmed';
                      });
                    }),
                _buildFilterButton('Completed',
                    selectedAppointmentStatus == 'Completed', () {
                      setState(() {
                        selectedAppointmentStatus = 'Completed';
                      });
                    }),
                _buildFilterButton('Cancelled',
                    selectedAppointmentStatus == 'Cancelled', () {
                      setState(() {
                        selectedAppointmentStatus = 'Cancelled';
                      });
                    }),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildResetFilter(),
                _buildApplyButton()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side:  BorderSide(color: Colors.grey.shade300, width: 1.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: Text(text),
    );
  }

  Widget _buildResetFilter(){
    return InkWell(
        onTap: (){
          setState(() {
            selectedGender = null;
            selectedAgeGroup = null;
            selectedAppointmentDate = null;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
          ),
          child: Text('Reset Filter', style: TextStyle(color: Colors.black)),
        )
    );
  }

  Widget _buildApplyButton(){
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.teal,
        ),
        child: Text('Apply', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}