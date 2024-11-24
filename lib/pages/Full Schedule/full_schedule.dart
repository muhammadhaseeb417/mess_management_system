import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/pages/user_panel/commons/meal_repressentation.dart';
import 'package:mess_management_system/utils/constants/colors.dart';
import 'package:mess_management_system/utils/constants/sizes.dart';

import '../../models/mess_recipesAndtiming.dart';
import '../../services/database_service.dart';

class FullSchedule extends StatefulWidget {
  const FullSchedule({super.key});

  @override
  State<FullSchedule> createState() => _FullScheduleState();
}

class _FullScheduleState extends State<FullSchedule> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  List<MessRecipes> _messRecipes = [];
  List<MessRecipes> _filteredRecipes = [];
  bool _isLoading = true;

  List<String> daysOfMess = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String _selectedDay = "";

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _selectedDay = daysOfMess[DateTime.now().weekday - 1]; // Select current day
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      // Fetch all recipes
      _messRecipes = await _databaseService.getAllRecipes();
      filterRecipesByDay(_selectedDay);
    } catch (e) {
      print("Error fetching recipes: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void filterRecipesByDay(String day) {
    setState(() {
      _filteredRecipes = _messRecipes
          .where((recipe) =>
              recipe.messDay ==
              day) // Assuming MessRecipes has a `messDay` property
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Page'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: TColors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("Search icon pressed");
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.lg),
            Row(
              children: [
                Text("Selected Day :   ",
                    style: Theme.of(context).textTheme.headlineSmall),
                DropdownButton<String>(
                  value: _selectedDay,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedDay = newValue;
                        filterRecipesByDay(newValue);
                      });
                    }
                  },
                  items: daysOfMess.map<DropdownMenuItem<String>>((String day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }).toList(),
                  dropdownColor: TColors.black,
                  style: const TextStyle(color: TColors.white),
                  underline: Container(
                    height: 2,
                    color: TColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.lg),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredRecipes.isEmpty
                      ? const Center(
                          child:
                              Text("No recipes available for the selected day"))
                      : ListView.builder(
                          itemCount: _filteredRecipes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: TSizes.spaceBtwItems,
                              ),
                              child: MealRepressentation(
                                upcomingRecipe: _filteredRecipes[index],
                              ),
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
