import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/controllers/score_controller.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';
import 'package:habit_trail_flutter/controllers/token_controller.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool browseOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "登录",
        screenAdaptation: false,
        useDefaultBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TDInput(
              type: TDInputType.normal,
              controller: usernameController,
              leftLabel: '用户名',
              hintText: '请输入用户名',
              backgroundColor: Colors.white,
              needClear: true,
            ),
            const SizedBox(height: 16),
            TDInput(
              type: TDInputType.normal,
              controller: passwordController,
              obscureText: !browseOn,
              leftLabel: '密码',
              hintText: '请输入密码',
              backgroundColor: Colors.white,
              rightBtn: browseOn
                  ? Icon(
                      TDIcons.browse,
                      color: TDTheme.of(context).fontGyColor3,
                    )
                  : Icon(
                      TDIcons.browse_off,
                      color: TDTheme.of(context).fontGyColor3,
                    ),
              onBtnTap: () {
                setState(() {
                  browseOn = !browseOn;
                });
              },
              needClear: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TDButton(
                theme: TDButtonTheme.primary,
                isBlock: true,
                shape: TDButtonShape.rectangle,
                onTap: () async {
                  final username = usernameController.text;
                  final password = passwordController.text;
                  await login(username, password);
                },
                child: const Text(
                  '登录',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: TDLink(
                state: TDLinkState.active,
                linkClick: (link) {
                  Get.toNamed('/register');
                },
                label: '还没有账号？点击注册',
              ),
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
    ActivityController activityController = Get.find<ActivityController>();
    ScoreController scoreController = Get.find<ScoreController>();
    await Future.wait([
      studentController.fetchStudentList(),
      activityController.fetchActivityList(),
      scoreController.fetchAll(),
    ]);
  }
}
