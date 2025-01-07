import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/utils/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenController extends GetxController {
  final _access = ''.obs;
  final _refresh = ''.obs;
  final httpClient = HttpClient();

  String getAccess() {
    return _access.value;
  }

  saveTokens(String access, String refresh) async {
    _access.value = access;
    _refresh.value = refresh;
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await httpClient.postWithoutToken('token/', {
        'username': username,
        'password': password,
      });

      if (response != null) {
        saveTokens(response['access'], response['refresh']);
        Get.offAllNamed('/home');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login failed: $e');
      }
    }
  }

  Future<bool> validateToken() async {
    if (_access.value.isEmpty) return false;

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(_access.value);
      var now = DateTime.now().millisecondsSinceEpoch;

      // If token expires in 5 minutes, refresh it
      if (decodedToken['exp'] * 1000 - now < 300000) {
        return await refreshTokens();
      }
      return true;
    } catch (e) {
      return await refreshTokens();
    }
  }

  Future<bool> refreshTokens() async {
    if (_refresh.value.isEmpty) {
      logout();
      return false;
    }

    try {
      final response = await httpClient
          .postWithoutToken('token/refresh/', {'refresh': _refresh.value});

      if (response.statusCode == 200) {
        saveTokens(response.data['access'], response.data['refresh']);
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Token refresh failed: $e');
      }
    }

    logout();
    return false;
  }

  void logout() {
    _access.value = '';
    _refresh.value = '';
    Get.offAllNamed('/login');
  }

  String getToken() {
    return _access.value;
  }

  bool isLoggedIn() {
    return _access.value.isNotEmpty;
  }

  register(String username, String email, String password) {
    httpClient.postWithoutToken('register/', {
      'username': username,
      'email': email,
      'password': password,
    });
  }
}
