import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/token_controller.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "注册",
        screenAdaptation: false,
        useDefaultBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0),
        child: Form(
          key: _formKey,
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
                controller: emailController,
                leftLabel: '邮箱',
                hintText: '请输入邮箱地址',
                backgroundColor: Colors.white,
                needClear: true,
              ),
              const SizedBox(height: 16),
              TDInput(
                type: TDInputType.normal,
                controller: passwordController,
                obscureText: true,
                leftLabel: '密码',
                hintText: '请输入密码',
                backgroundColor: Colors.white,
                needClear: true,
              ),
              const SizedBox(height: 16),
              TDInput(
                type: TDInputType.normal,
                controller: confirmPasswordController,
                obscureText: true,
                leftLabel: '密码',
                hintText: '请再次输入密码',
                backgroundColor: Colors.white,
                needClear: true,
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TDButton(
                  theme: TDButtonTheme.primary,
                  isBlock: true,
                  shape: TDButtonShape.rectangle,
                  onTap: () async {
                    await register(context);
                  },
                  child: const Text(
                    '注册',
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
                    Get.toNamed('/login');
                  },
                  label: '已经有账号？点击登录',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register(context) async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      TDToast.showFail("请填写完整信息", context: context);
      return;
    }
    if (password != confirmPassword) {
      TDToast.showFail("两次密码不一致", context: context);
      return;
    }
    if (username.length < 6 || username.length > 16) {
      TDToast.showFail("用户名长度为6-16位", context: context);
    }
    if (password.length < 6 || password.length > 16) {
      TDToast.showFail("密码长度为6-16位", context: context);
    }
    // 密码验证，必须包含数字和字母
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,16}$')
        .hasMatch(password)) {
      TDToast.showFail("密码必须包含数字和字母", context: context);
      return;
    }
    TokenController tokenController = Get.find<TokenController>();
    tokenController.register(username, email, password);
  }
}
