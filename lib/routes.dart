import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:habit_trail_flutter/pages/award_details.dart';
import 'package:habit_trail_flutter/pages/create_task.dart';
import 'package:habit_trail_flutter/pages/create_award.dart';
import 'package:habit_trail_flutter/pages/task_details.dart';
import 'package:habit_trail_flutter/pages/home.dart';
import 'package:habit_trail_flutter/pages/login.dart';
import 'package:habit_trail_flutter/pages/register.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int get priority => 1; // 可选：设置中间件优先级

  @override
  RouteSettings? redirect(String? route) {
    final hasToken = checkIfTokenExists();

    if (!hasToken) {
      return const RouteSettings(name: '/login'); // 返回 RouteSettings 对象
    }
    return null; // 返回 null 表示不拦截
  }

  bool checkIfTokenExists() {
    // 替换为实际的 token 检查逻辑（如 SharedPreferences、本地状态等）
    return false;
  }
}

var routes = [
  GetPage(
      name: '/home', page: () => const Home(), middlewares: [AuthMiddleware()]),
  GetPage(
    name: '/createTask',
    page: () => const CreateTask(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/createAward',
    page: () => const CreateAward(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/awardDetails',
    page: () => AwardDetails(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/taskDetails',
    page: () => TaskDetails(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(name: '/login', page: () => const LoginPage()),
  GetPage(name: '/register', page: () => RegisterPage()),
];
