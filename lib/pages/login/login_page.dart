import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/utils/constants/reg_exp.dart';

import '../../services/auth_service.dart';
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
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  String? _email, _password;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSizes.defaultSpace * 3,
          horizontal: TSizes.defaultSpace,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _loginHeader(context),
            const SizedBox(height: TSizes.xl),
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
        const SizedBox(height: TSizes.appBarHeight),
        Image.asset(isDark ? TImages.darkAppLogo : TImages.lightAppLogo),
        const SizedBox(height: TSizes.defaultSpace),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "E-Mail",
            prefixIcon: const Icon(Icons.email),
            validateRegExp: EMAIL_VALIDATION_REGEX,
            onSaved: (value) => _email = value,
          ),
          const SizedBox(height: TSizes.lg),
          CustomTextField(
            hintText: "Password",
            prefixIcon: const Icon(Icons.password),
            obsureText: true,
            validateRegExp: PASSWORD_VALIDATION_REGEX,
            onSaved: (value) => _password = value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() => _rememberMe = value ?? false);
                    },
                  ),
                  const Text(TTexts.rememberMe),
                ],
              ),
              const Text(TTexts.forgetPassword),
            ],
          ),
          const SizedBox(height: TSizes.xl * 3),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() => _isLoading = true);
                      try {
                        if (_loginKey.currentState?.validate() ?? false) {
                          _loginKey.currentState?.save();

                          if (_email == "admin@admin.com" &&
                              _password == "Admin@123") {
                            Navigator.pushReplacementNamed(context, "/admin");
                            _showSnackBar(
                                context, "Admin Successfully Logged In");
                            return;
                          }

                          bool result =
                              await _authService.login(_email!, _password!);
                          if (result) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNavigation(),
                              ),
                            );
                            _showSnackBar(
                                context, "User Successfully Logged In");
                          } else {
                            _showSnackBar(context, "Please try again.");
                          }
                        } else {
                          _showSnackBar(context, "Please try again.");
                        }
                      } catch (e) {
                        _showSnackBar(
                            context, "An error occurred. Please try again.");
                        print(e);
                      } finally {
                        if (mounted) {
                          setState(() => _isLoading = false);
                        }
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(TTexts.logIn),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        ),
                      );
                    },
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
