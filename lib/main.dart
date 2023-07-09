import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo/resource/app_colors.dart';
import 'package:todo/resource/app_strings.dart';
import 'package:todo/screens/screen_employees.dart';

import 'get/get_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.strAppName,
      theme: ThemeData(
        primarySwatch: AppColors.appThemeColor,
        fontFamily: 'AppFont',
      ),
      home: ScreenEmployees(),
      getPages: AppPages.pages,
    );
  }
}
