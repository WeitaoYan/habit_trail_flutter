import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/controllers/score_controller.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';
import 'package:habit_trail_flutter/controllers/token_controller.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.find<TokenController>().accessToken.value != "") {
      Get.offNamed('/home');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final username = usernameController.text;
                  final password = passwordController.text;
                  await login(username, password);
                },
                child: const Text('登录'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: const Text('还没有账号？点击注册'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(String username, String password) async {
    TokenController tokenController = Get.find<TokenController>();
    await tokenController.login(username, password);
    StudentController studentController = Get.find<StudentController>();
    await studentController.fetchStudentList();
    ActivityController activityController = Get.find<ActivityController>();
    await activityController.fetchActivityList();
    ScoreController scoreController = Get.find<ScoreController>();
    await scoreController.fetchAll();
  }
}
