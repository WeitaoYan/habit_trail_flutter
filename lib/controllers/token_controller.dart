import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../utils/http.dart';

class TokenController extends GetxController {
  late Rx<String> accessToken = "".obs;
  late Rx<String> refreshToken = "".obs;

  Future login(username, password) async {
    HttpClient client = HttpClient();
    final response = await client.postWithoutToken('token/', {
      'username': username,
      'password': password,
    });
    processToken(response, "登录");
  }

  void processToken(dynamic response, String type) {
    if (kDebugMode) {
      print("processToken");
      print(response);
    }
    if (response != null && response['access'] != null) {
      accessToken.value = response['access'];
      refreshToken.value = response['refresh'];
      Get.offNamed('/home');
    } else {
      Get.snackbar('错误', '$type失败');
    }
  }

  Future<bool> hasValidToken() async {
    if (accessToken.value != "" && refreshToken.value != "") {
      Map<String, dynamic> decodedAccessToken =
          JwtDecoder.decode(accessToken.value);
      var now = DateTime.now().millisecondsSinceEpoch;
      return (decodedAccessToken['exp'] * 1000 < now);
    }
    Get.offAllNamed('/login');
    return false;
  }

  Future<void> doRefreshToken() async {
    if (refreshToken.value != "") {
      Map<String, dynamic> decodedRefreshToken =
          JwtDecoder.decode(refreshToken.value);
      var now = DateTime.now().millisecondsSinceEpoch;
      if (decodedRefreshToken['exp'] * 1000 > now) {
        HttpClient httpClient = HttpClient();
        final response = await httpClient.postWithoutToken('token/refresh/', {
          'refresh': refreshToken,
        });
        if (kDebugMode) {
          print("refreshToken");
          print(response);
        }
      }
    }
    Get.offAllNamed('/login');
  }

  Future register(username, email, password) async {
    HttpClient client = HttpClient();
    final response = await client.postWithoutToken('register/', {
      'username': username,
      'email': email,
      'password': password,
    });
    processToken(response, "注册");
  }

  Future loginWithToken() async {
    HttpClient client = HttpClient();
    final response = await client.postWithoutToken('token/refresh/', {
      'refresh': refreshToken,
    });
    processToken(response, "刷新登录");
  }
}
