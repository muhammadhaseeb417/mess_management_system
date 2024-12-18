import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/services/storage_servive.dart';
import 'dart:async';

import '../../../models/mess_recipesAndtiming.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MealRepressentation extends StatefulWidget {
  final MessRecipes? upcomingRecipe;

  const MealRepressentation({super.key, this.upcomingRecipe});

  @override
  State<MealRepressentation> createState() => _MealRepresentationState();
}

class _MealRepresentationState extends State<MealRepressentation> {
  Timer? _timer;
  String _timeUntilMeal = '';
  final GetIt _getIt = GetIt.instance;
  late StorageServive _storageServive;
  String? upcomingMealRecipeImgUrl;

  @override
  void initState() {
    super.initState();
    _updateTimeUntilMeal();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateTimeUntilMeal();
    });
    _storageServive = _getIt.get<StorageServive>();
    getUpcomingMealRecipeImgUrl();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void getUpcomingMealRecipeImgUrl() async {
    upcomingMealRecipeImgUrl = await _storageServive.getRecipeImageUrl(
        uid: widget.upcomingRecipe!.recipeId);
    print("Fetched Image URL: $upcomingMealRecipeImgUrl");
  }

  void _updateTimeUntilMeal() {
    if (widget.upcomingRecipe == null) return;

    DateTime now = DateTime.now();
    DateTime mealTime = _getMealDateTime(
        widget.upcomingRecipe!.messTime, widget.upcomingRecipe!.messDay);
    Duration difference = mealTime.difference(now);

    if (difference.isNegative) {
      setState(() {
        _timeUntilMeal = 'Meal time has passed';
      });
      return;
    }

    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    setState(() {
      _timeUntilMeal = '$hours hrs $minutes mins';
    });
  }

  DateTime _getMealDateTime(String messTime, String messDay) {
    DateTime now = DateTime.now();
    bool isMorning = messTime.contains("Morning");

    // Parse the time from the messTime string
    int hour = isMorning ? 11 : 18;
    int minute = isMorning ? 45 : 30;

    // Get the weekday index for the mess day
    int targetWeekday = _getWeekdayIndex(messDay);

    // Calculate days to add to reach the target day
    int daysToAdd = (targetWeekday - now.weekday + 7) % 7;

    // If it's the same day but time has passed, add 7 days
    if (daysToAdd == 0) {
      DateTime mealDateTime =
          DateTime(now.year, now.month, now.day, hour, minute);
      if (mealDateTime.isBefore(now)) {
        daysToAdd = 7;
      }
    }

    return DateTime(
      now.year,
      now.month,
      now.day + daysToAdd,
      hour,
      minute,
    );
  }

  int _getWeekdayIndex(String day) {
    const days = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };
    return days[day] ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        color: TColors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(
          TSizes.buttonRadius,
        ),
        image: DecorationImage(
          image: upcomingMealRecipeImgUrl != null
              ? NetworkImage(upcomingMealRecipeImgUrl!)
              : AssetImage("assets/images/food/biryani.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.upcomingRecipe!.recipeName,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(5.0, 2.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(widget.upcomingRecipe!.messTime.split(' ')[0]),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.lg,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time: $_timeUntilMeal',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(-2.0, 2.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.black,
                  side: const BorderSide(color: TColors.black),
                ),
                child: const Text('Cancel'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
