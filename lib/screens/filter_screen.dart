import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';



class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Consultation Type
  String selectedConsultation = 'Online';

  // Budget Range
  double minBudget = 200;
  double maxBudget = 1000;

  // Reviews
  String selectedReview = '4.5 and above';
  List<String> reviewOptions = [
    '4.5 and above',
    '4.0 - 4.4',
    '3.5 - 3.9',
    '3.0 - 3.4',
    '2.5 - 2.9'
  ];

  // Doctor's Experience
  List<String> experienceLevels = ['0-2 years', '3-5 years', '6-10 years', '11-15 years'];
  String selectedExperience = '0-2 years';

  // Availability
  List<String> availabilityOptions = ['Available Today', 'Available This Week', 'Weekend Appointments'];
  String selectedAvailability = 'Available Today';

  // Reset Filters Function
  void resetFilters() {
    setState(() {
      selectedConsultation = 'Online';
      minBudget = 200;
      maxBudget = 1000;
      selectedReview = '4.5 and above';
      selectedExperience = '0-2 years';
      selectedAvailability = 'Available Today';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Filtration', style: TextStyle(color: Colors.black)),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Consultation Type', style: TextStyle(
                  fontWeight: FontWeight.bold)),
              SizedBox(height: 5,),
              Row(
                children: ['Online', 'In-Person'].map((type) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: selectedConsultation == type,
                      onSelected: (selected) {
                        setState(() {
                          selectedConsultation = type;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: MyColors.mainColor, // Border color
                          width: 1.5, // Border thickness
                        ),
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      selectedColor: MyColors.mainColor,
                      labelStyle: TextStyle(color: selectedConsultation == type ? Colors.white : MyColors.mainColor),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
          
              Text('Budget Range', style: TextStyle(fontWeight: FontWeight.bold)),
              RangeSlider(
                activeColor: MyColors.mainColor,
                values: RangeValues(minBudget, maxBudget),
                min: 200,
                max: 2000,
                divisions: 5,
                labels: RangeLabels(
                    '\$${minBudget.toInt()}', '\$${maxBudget.toInt()}'
                ),
                onChanged: (values) {
                  setState(() {
                    minBudget = values.start;
                    maxBudget = values.end;
                  });
                },
              ),
              SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$200"),
                  Text("\$250"),
                  Text("\$500"),
                  Text("\$750"),
                  Text("\$1000"),
                  Text("\$2000"),
                ],
              ),
              SizedBox(height: 20),
          
              Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: reviewOptions.map((review) {
                  return RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Text(review),
                        Spacer(),
                      ],
                    ),
                    value: review,
                    groupValue: selectedReview,
                    onChanged: (value) {
                      setState(() {
                        selectedReview = value.toString();
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
          
              Text("Doctor's Experience", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: experienceLevels.map((exp) {
                  return ChoiceChip(
                    label: Text(exp),
                    selected: selectedExperience == exp,
                    onSelected: (selected) {
                      setState(() {
                        selectedExperience = exp;
                      });
                    },
                    selectedColor: MyColors.mainColor,
                    labelStyle: TextStyle(color: selectedExperience == exp ? Colors.white : MyColors.mainColor),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
          
              Text("Availability", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: availabilityOptions.map((avail) {
                  return ChoiceChip(
                    label: Text(avail),
                    selected: selectedAvailability == avail,
                    onSelected: (selected) {
                      setState(() {
                        selectedAvailability = avail;
                      });
                    },
                    selectedColor: MyColors.mainColor,
                    labelStyle: TextStyle(color: selectedAvailability == avail ? Colors.white : MyColors.mainColor),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
          
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: resetFilters,
                      child: Container(
                        width: MediaQuery.of(context).size.width*.35,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: MyColors.mainColor)
                        ),
                        child: Center(child: Text("Reset Filter", style: TextStyle(color: MyColors.mainColor),)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: MediaQuery.of(context).size.width*.35,
                        height: 40,
                        decoration: BoxDecoration(
                            color: MyColors.mainColor,
                        borderRadius: BorderRadius.circular(3)
                        ),
                        child: Center(child: Text("Apply", style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

