import 'package:get/get.dart';
import 'package:habit_trail_flutter/pages/award_details.dart';
import 'package:habit_trail_flutter/pages/task_details.dart';
import 'package:habit_trail_flutter/pages/home.dart';
import 'package:habit_trail_flutter/pages/login.dart';
import 'package:habit_trail_flutter/pages/register.dart';

var routes = [
  GetPage(name: '/home', page: () => const Home()),
  GetPage(name: '/awardDetails', page: () => AwardDetails()),
  GetPage(name: '/taskDetails', page: () => TaskDetails()),
  GetPage(name: '/login', page: () => LoginPage()),
  GetPage(name: '/register', page: () => RegisterPage()),
];
