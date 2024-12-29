import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';
import 'package:habit_trail_flutter/controllers/token_controller.dart';
import 'package:habit_trail_flutter/pages/login.dart';
import 'package:habit_trail_flutter/routes.dart';
import 'package:habit_trail_flutter/controllers/score_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      getPages: routes,
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => TokenController());
        Get.lazyPut(() => StudentController());
        Get.lazyPut(() => ActivityController());
        Get.lazyPut(() => ScoreController());
      }),
    );
  }
}

void main() => runApp(const MyApp());