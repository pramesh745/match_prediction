import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:match_prediction_app/core/api_const.dart';
import 'package:match_prediction_app/core/models/auth_token.dart';
import 'package:match_prediction_app/utils/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;


  Future<bool> postRegister({
    required String displayName,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiConst.registerApi);
      final success = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": displayName,
          "email": email,
          "password": password,
        }),
      );
      if (success.statusCode == 200 || success.statusCode == 201) {
        return true;
      } else {
        _errorMessage = "Failed to register: ${success.statusCode}";
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> postLogin({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ApiConst.loginApi);
      final success = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (success.statusCode == 200 || success.statusCode == 201) {
        Map<String, dynamic> json = jsonDecode(success.body);
        AuthToken authToken = AuthToken.fromJson(json);
        await TokenStorage.saveToken(authToken.accessToken ?? "");
        return true;
      } else {
        _errorMessage = "Failed to save token";
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
