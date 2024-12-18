import 'package:flutter/material.dart';
import 'package:mess_management_system/utils/constants/reg_exp.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../bottom_navigation/bottom_navigation.dart';
import '../signUp/signUp_page.dart';
import 'widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool isDark;

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context); // Initialize here
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.defaultSpace * 3, horizontal: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _loginHeader(context),
            const SizedBox(
              height: TSizes.xl,
            ),
            _loginForm(context),
          ],
        ),
      ),
    );
  }

  Widget _loginHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: TSizes.appBarHeight,
        ),
        Image.asset(
          isDark ? TImages.darkAppLogo : TImages.lightAppLogo,
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(
            hintText: "E-Mail",
            prefixIcon: Icon(Icons.email),
            validateRegExp: EMAIL_VALIDATION_REGEX,
          ),
          const SizedBox(
            height: TSizes.lg,
          ),
          CustomTextField(
            hintText: "Password",
            prefixIcon: Icon(Icons.password),
            surfixIcon: Icon(Icons.remove_red_eye),
            obsureText: true,
            validateRegExp: PASSWORD_VALIDATION_REGEX,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const Text(TTexts.rememberMe),
                ],
              ),
              const Text(TTexts.forgetPassword),
            ],
          ),
          const SizedBox(
            height: TSizes.xl * 3,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const BottomNavigation();
                    },
                  ),
                );
              },
              child: const Text(
                TTexts.logIn,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const SignupPage();
                  },
                ));
              },
              child: const Text(
                TTexts.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
