import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/pages/authentication/models/user_model.dart';
import 'package:mess_management_system/pages/bottom_navigation/bottom_navigation.dart';
import 'package:mess_management_system/pages/signUp/signUp_provider.dart';
import 'package:mess_management_system/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../../services/database_service.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/reg_exp.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../login/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late DatabaseService _databaseService;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _databaseService = _getIt.get<DatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);
    GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

    String? firstName,
        lastName,
        email,
        session,
        dept,
        rollNo,
        password,
        confirmPassward;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isDark ? TColors.white : TColors.black,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      TTexts.signupTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: TSizes.xl,
                    ),
                    Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hintText: "First Name",
                                  prefixIcon: Icon(Icons.person),
                                  onSaved: (p0) {
                                    firstName = p0;
                                  },
                                  validateRegExp: FIRST_NAME_VALIDATION_REGEX,
                                ),
                              ),
                              const SizedBox(
                                width: TSizes.lg,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  hintText: "Last Name",
                                  prefixIcon: Icon(Icons.person),
                                  onSaved: (p0) {
                                    lastName = p0;
                                  },
                                  validateRegExp: LAST_NAME_VALIDATION_REGEX,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          CustomTextField(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            validateRegExp: EMAIL_VALIDATION_REGEX,
                            onSaved: (p0) {
                              email = p0;
                            },
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          CustomTextField(
                            hintText: "Session (20XX)",
                            prefixIcon: Icon(Icons.info),
                            validateRegExp: SESSION_VALIDATION_REGEX,
                            onSaved: (p0) {
                              session = p0;
                            },
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          CustomTextField(
                            hintText: "Department (CS,EE, ME, IME)",
                            prefixIcon: Icon(Icons.add_home_work_rounded),
                            validateRegExp: DEPARTMENT_VALIDATION_REGEX,
                            onSaved: (p0) {
                              dept = p0;
                            },
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          CustomTextField(
                            hintText: "Roll No (400, XXX)",
                            prefixIcon: Icon(Icons.assignment_ind_rounded),
                            validateRegExp: ROLL_NO_VALIDATION_REGEX,
                            onSaved: (p0) {
                              rollNo = p0;
                            },
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          CustomTextField(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            validateRegExp: PASSWORD_VALIDATION_REGEX,
                            obsureText: true,
                            onSaved: (p0) {
                              password = p0;
                            },
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          CustomTextField(
                            hintText: "Confirm Password",
                            prefixIcon: Icon(Icons.password),
                            validateRegExp: PASSWORD_VALIDATION_REGEX,
                            obsureText: true,
                            onSaved: (p0) {
                              confirmPassward = p0;
                            },
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Consumer<SignupProvider>(
                              builder: (context, values, index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: values.checkBoxValue,
                                    onChanged: (value) {
                                      values.ChangeCheckBoxValue(value);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: TSizes.sm,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${TTexts.iAgreeTo} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      TTexts.privacyPolicy,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: isDark
                                                ? TColors.white
                                                : TColors.black,
                                          ),
                                    ),
                                    Text(
                                      " ${TTexts.and} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      TTexts.termsOfUse,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .apply(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: isDark
                                                ? TColors.white
                                                : TColors.black,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                          const SizedBox(
                            height: TSizes.xl,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (_signUpKey.currentState?.validate() ??
                                      false) {
                                    _signUpKey.currentState?.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    bool result = await _authService.Register(
                                        email!, password!);
                                    if (result) {
                                      await _databaseService
                                          .createUserInFirebase(
                                              user: UserModel(
                                                  uid: _authService.user!.uid,
                                                  first_name: firstName!,
                                                  last_name: lastName!,
                                                  email: email!,
                                                  session: session!,
                                                  departemnt: dept!,
                                                  rollNumber: rollNo!,
                                                  mealAttendance: []));
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return BottomNavigation();
                                        },
                                      ));
                                      Get.rawSnackbar(
                                        duration: Duration(seconds: 3),
                                        icon: Icon(Icons.info_outline),
                                        message: "User Registered successfully",
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.rawSnackbar(
                                      duration: Duration(seconds: 3),
                                      icon: Icon(Icons.error),
                                      message: "Please retry an error occured",
                                    );
                                  }
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print(e);
                                }
                              },
                              child: const Text(TTexts.createAccount),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
