import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mess_management_system/pages/Full%20Schedule/full_schedule.dart';
import 'package:mess_management_system/pages/bill/bill_screen.dart';
import 'package:mess_management_system/pages/current%20bill/current_bill_screen.dart';
import 'package:mess_management_system/pages/view%20attendence/view_attendence_screen.dart';
import 'package:mess_management_system/pages/view%20cut%20attendence/view_cut_attendence.dart';

import '../../models/mess_recipesAndtiming.dart';
import '../../services/database_service.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import 'commons/custom_info_button.dart';
import 'commons/meal_repressentation.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  List<MessRecipes> _messRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    fetchRecipes();
    fetchUpcomingMess();
  }

  Future<void> fetchRecipes() async {
    try {
      // Assuming DatabaseService is already instantiated
      _messRecipes = await _databaseService.getAllRecipes();

      print(_messRecipes[0].recipeName);
    } catch (e) {
      print("Error fetching recipes: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<MessRecipes?> fetchUpcomingMess() async {
    try {
      List<MessRecipes> allRecipes = await _databaseService.getAllRecipes();
      if (allRecipes.isEmpty) {
        print("No recipes found in the database.");
        return null;
      }

      DateTime now = DateTime.now();
      MessRecipes? upcomingRecipe;
      Duration closestDuration = Duration(days: 7);

      for (var recipe in allRecipes) {
        int targetWeekday = getWeekdayIndex(recipe.messDay);
        DateTime recipeDateTime =
            calculateNextOccurrence(now, targetWeekday, recipe.messTime);

        if (recipeDateTime.isAfter(now)) {
          Duration difference = recipeDateTime.difference(now);
          if (difference < closestDuration) {
            closestDuration = difference;
            upcomingRecipe = recipe;
          }
        }
      }

      return upcomingRecipe;
    } catch (e, stackTrace) {
      print("Error fetching recipes: $e");
      print("Stack trace: $stackTrace");
      rethrow; // Rethrow the exception so it can be handled in the FutureBuilder
    }
  }

  DateTime calculateNextOccurrence(
      DateTime now, int targetWeekday, String messTime) {
    // Calculate days until next occurrence
    int daysToAdd = (targetWeekday - now.weekday + 7) % 7;

    // Parse the time from messTime
    bool isMorning = messTime == "Morning (11:45)";
    int targetHour = isMorning ? 11 : 18;
    int targetMinute = isMorning ? 45 : 30;

    // Create DateTime for the next occurrence
    DateTime targetDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      targetHour,
      targetMinute,
    );

    // If it's the same day but the time has passed, add 7 days
    if (daysToAdd == 0) {
      if ((targetHour < now.hour) ||
          (targetHour == now.hour && targetMinute <= now.minute)) {
        daysToAdd = 7;
      }
    }

    // Add the required number of days
    return targetDateTime.add(Duration(days: daysToAdd));
  }

// Helper method to convert day name to weekday index
  int getWeekdayIndex(String day) {
    switch (day) {
      case "Monday":
        return 1;
      case "Tuesday":
        return 2;
      case "Wednesday":
        return 3;
      case "Thursday":
        return 4;
      case "Friday":
        return 5;
      case "Saturday":
        return 6;
      case "Sunday":
        return 7;
      default:
        throw Exception("Invalid day: $day");
    }
  }

// Helper method to get the name of the day from the weekday index
  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        throw Exception("Invalid weekday index: $weekday");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Lottie.asset(
                    "assets/animations/Rachna MMS Container.json",
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    // Adjust fit if necessary
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'Welcome to Rachna Mess Management \nSystem',
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: TColors.black.withOpacity(0.7),
                          fontWeightDelta: 20,
                          fontSizeDelta: 9,
                        ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const FullSchedule();
                          },
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.black,
                        side: const BorderSide(color: TColors.black),
                        elevation: 0,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: TSizes.xs),
                        child: Text(
                          'See Schedule',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.grey, // Color of the left divider
                    thickness: 1, // Thickness of the divider
                    endIndent: 10, // Spacing between divider and text
                  ),
                ),
                Text(
                  "Information",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey, // Color of the right divider
                    thickness: 1,
                    indent: 10, // Spacing between text and divider
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            _infobuttons(context),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.grey, // Color of the left divider
                    thickness: 1, // Thickness of the divider
                    endIndent: 10, // Spacing between divider and text
                  ),
                ),
                Text(
                  "Upcoming Meal",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey, // Color of the right divider
                    thickness: 1,
                    indent: 10, // Spacing between text and divider
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            FutureBuilder<MessRecipes?>(
              future: fetchUpcomingMess(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return Center(child: Text('No upcoming meals found.'));
                } else {
                  final upcomingRecipe = snapshot.data!;
                  print(upcomingRecipe.recipeId);
                  if (upcomingRecipe.recipeId != null) {
                    // HttpService.getRecipeImageResponse(
                    //   recipeId: upcomingRecipe.recipeId!,
                    //   endPoint: "recipe-image",
                    // );
                  }
                  return MealRepressentation(upcomingRecipe: upcomingRecipe);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infobuttons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomInfoButton(
                btnText: "View Current Bill",
                backgroundColor: Colors.green,
                pageCallback: () => CurrentBillScreen(),
              ),
            ),
            SizedBox(
              width: TSizes.lg,
            ),
            Expanded(
              child: CustomInfoButton(
                btnText: "View Attendence",
                backgroundColor: Color.fromARGB(255, 164, 148, 11),
                pageCallback: () => ViewAttendenceScreen(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Expanded(
              child: CustomInfoButton(
                btnText: "Bills",
                backgroundColor: Colors.blue,
                pageCallback: () => BillScreen(),
              ),
            ),
            SizedBox(
              width: TSizes.lg,
            ),
            Expanded(
              child: CustomInfoButton(
                btnText: "View Cut Attendence",
                backgroundColor: Colors.red,
                pageCallback: () => ViewCutAttendence(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
