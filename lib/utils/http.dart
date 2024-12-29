import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:habit_trail_flutter/controllers/token_controller.dart';

class HttpClient {
  final String baseUrl = "https://yanweitao.pythonanywhere.com/api/";

  HttpClient();

  String _getToken() {
    TokenController tokenController = Get.find();
    return tokenController.accessToken.value;
  }

  Future<dynamic> get(String endpoint, {bool showSnackbar = true}) async {
    String token = _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Accept': 'application/json; charset=utf-8',
        if (token != "") 'Authorization': 'Bearer $token',
      },
    );

    return _processResponse(response, showSnackbar);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {bool showSnackbar = false}) async {
    String token = _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
        if (token != "") 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    return _processResponse(response, false);
  }

  Future<dynamic> postWithoutToken(String endpoint, Map<String, dynamic> body,
      {bool showSnackbar = false}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
      body: jsonEncode(body),
    );

    return _processResponse(response, showSnackbar);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body,
      {bool showSnackbar = true}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
      body: jsonEncode(body),
    );

    return _processResponse(response, showSnackbar);
  }

  Future<dynamic> delete(String endpoint, {bool showSnackbar = true}) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Accept': 'application/json; charset=utf-8'},
    );

    return _processResponse(response, showSnackbar);
  }

  dynamic _processResponse(http.Response response, bool showSnackbar) {
    int statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else if (statusCode >= 400 && statusCode < 500 && showSnackbar) {
      // Get.snackbar("错误", "没有找到你想要的资源");
    } else if (statusCode >= 500 && showSnackbar) {
      // Get.snackbar("服务器忙", "服务器太忙了，可以等会再试");
    }
  }
}
