import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/utils/constants/reg_exp.dart';

import '../../models/mess_recipesAndtiming.dart';
import '../../services/database_service.dart';
import '../../services/media_service.dart';
import '../../services/storage_servive.dart';
import '../../utils/constants/sizes.dart';
import '../login/widgets/custom_text_field.dart';

class AdminDashboardRachna extends StatefulWidget {
  const AdminDashboardRachna({super.key});

  @override
  State<AdminDashboardRachna> createState() => _AdminDashboardRachnaState();
}

class _AdminDashboardRachnaState extends State<AdminDashboardRachna> {
  final GlobalKey<FormState> _messRecipeKey = GlobalKey();
  String? recipeName, recipePrice;
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StorageServive _storageServive;

  bool isSubmittingInfo = false;

  File? selectedImage = null;

  List<String> daysOfMess = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<String> timeOfMess = [
    "Morning (11:45)",
    "Evening (After Magrib)",
  ];

  // Variables to track selected day and time
  String? selectedDay;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _mediaService = _getIt.get<MediaService>();
    _storageServive = _getIt.get<StorageServive>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meals'),
      ),
      body: isSubmittingInfo
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _addRecipePicture(context),
                    _addRecipeForm(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _addRecipePicture(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            File? file = await _mediaService.getMediaImageFromUserGallery();
            if (file != null) {
              setState(() {
                selectedImage = file;
              });
            }
          },
          child: DottedBorder(
            color: Colors.white,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius: Radius.circular(TSizes.buttonRadius),
            dashPattern: const [8],
            child: Container(
              width: double.maxFinite,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                image: selectedImage != null
                    ? DecorationImage(
                        image: FileImage(selectedImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: selectedImage == null
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined),
                        Text('Add Recipe Image'),
                      ],
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        )
      ],
    );
  }

  Widget _addRecipeForm(BuildContext context) {
    return Form(
      key: _messRecipeKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Recipe Name",
            prefixIcon: Icon(Icons.food_bank_outlined),
            onSaved: (value) => recipeName = value,
            validateRegExp: STRING_VALIDATION_REGEX,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          CustomTextField(
            hintText: "Recipe Price",
            prefixIcon: const Icon(Icons.food_bank_outlined),
            onSaved: (value) => recipePrice = value,
            validateRegExp: NUMBER_VALIDATION_REGEX,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          _addDatetimeMessRecipe(context),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isSubmittingInfo = true;
                });
                if (_messRecipeKey.currentState?.validate() ?? false) {
                  _messRecipeKey.currentState?.save();

                  String? recipeImageURL;

                  if (selectedImage != null) {
                    recipeImageURL = await _storageServive.uploadRecipeImage(
                        file: selectedImage!, uid: DateTime.now().toString());
                  }
                  String recipeId =
                      await _databaseService.createMessRecipeInFirebase(
                    messRecipes: MessRecipes(
                      recipeName: recipeName!,
                      recipePrice: double.parse(recipePrice!),
                      messDay: selectedDay!,
                      messTime: selectedTime!,
                      recipeId: "",
                      imageURL:
                          recipeImageURL, // This field is updated in Firebase
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.info, color: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(
                              child:
                                  Text("Recipe has been successfully created")),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );

                  _messRecipeKey.currentState?.reset();

                  selectedImage = null;

                  selectedDay = null;
                  selectedTime = null;

                  setState(() {});
                }
                setState(() {
                  isSubmittingInfo = false;
                });
              },
              child: const Text('Submit'),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
        ],
      ),
    );
  }

  Widget _addDatetimeMessRecipe(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: TSizes.spaceBtwItems),

        // Divider with "Select Day" label
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                endIndent: 10,
              ),
            ),
            Text(
              "Select Day",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Wrap for day selection with color change on selection
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: daysOfMess.map((day) {
            final isSelected = day == selectedDay;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDay = day;
                });
              },
              child: Chip(
                label: Text(day),
                backgroundColor: isSelected ? Colors.blue : Colors.grey[900],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Divider with "Select Time" label
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                endIndent: 10,
              ),
            ),
            Text(
              "Select Time",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Expanded(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Wrap for time selection with color change on selection
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: timeOfMess.map((time) {
            final isSelected = time == selectedTime;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTime = time;
                });
              },
              child: Chip(
                label: Text(time),
                backgroundColor: isSelected ? Colors.green : Colors.grey[900],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}
