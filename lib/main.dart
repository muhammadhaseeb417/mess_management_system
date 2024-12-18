import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/pages/bottom_navigation/bottom_navigation.dart';
import 'package:mess_management_system/pages/signUp/signUp_provider.dart';
import 'package:mess_management_system/pages/user_panel/user_dashboard.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/bottom_navigation/bloc/bottom_nav_bar_bloc.dart';
import 'pages/login/login_page.dart';
import 'services/auth_service.dart';
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RegisterServics();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;

  MyApp({super.key}) {
    _authService = _getIt.get<AuthService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarBloc(),
      child: GetMaterialApp(
        title: TTexts.appName,
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: _authService.user != null ? BottomNavigation() : LoginPage(),
      ),
    );
  }
}
