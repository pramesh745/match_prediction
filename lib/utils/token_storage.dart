import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _accessTokenKey = "access_token";



  static Future<void>saveToken(String accessToken)async{

    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  static Future<bool>logout()async{
    await _storage.deleteAll();
    return true;
  }


  static Future<bool>isLoggedIn() async{
    final token = await _storage.read(key: _accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<String?>fetchToken()async{
    return await _storage.read(key: _accessTokenKey);
  }

}