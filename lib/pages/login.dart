import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/controllers/score_controller.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';
import 'package:habit_trail_flutter/controllers/token_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool browseOn = false;
  bool rememberPassword = false; // 新增记住密码的状态变量

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials(); // 加载保存的凭证
  }

  // 加载保存的凭证
  Future<void> _loadSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedUsername = prefs.getString('username');
    final String? savedPassword = prefs.getString('password');
    final bool? savedRememberPassword = prefs.getBool('rememberPassword');

    if (savedUsername != null &&
        savedPassword != null &&
        savedRememberPassword == true) {
      usernameController.text = savedUsername;
      passwordController.text = savedPassword;
      rememberPassword = true;
      setState(() {});
    }
  }

  // 保存凭证
  Future<void> _saveCredentials(
    String username,
    String password,
    bool remember,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (remember) {
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      await prefs.setBool('rememberPassword', true);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.remove('rememberPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "登录",
        screenAdaptation: true,
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
              leftIcon: const Icon(
                Icons.person_2,
                color: Colors.black54,
              ),
              hintText: '请输入用户名',
              backgroundColor: Colors.white,
              needClear: true,
            ),
            const SizedBox(height: 16),
            TDInput(
              type: TDInputType.normal,
              controller: passwordController,
              obscureText: !browseOn,
              leftIcon: const Icon(
                Icons.lock,
                color: Colors.black54,
              ),
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
            Row(
              children: [
                TDCheckbox(
                  checked: rememberPassword,
                  onCheckBoxChanged: (selected) {
                    setState(() {
                      rememberPassword = selected;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const Text('记住密码'),
              ],
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
                  await _saveCredentials(
                      username, password, rememberPassword); // 保存凭证
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
    await studentController.fetchStudentList();
    ActivityController activityController = Get.find<ActivityController>();
    ScoreController scoreController = Get.find<ScoreController>();
    await Future.wait([
      activityController.fetchActivityList(),
      scoreController.fetchInitScore(),
    ]);
  }
}
