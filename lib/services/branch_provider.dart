import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:match_prediction_app/core/api_const.dart';
import 'package:match_prediction_app/utils/token_storage.dart';

import '../core/models/get_auth_me.dart';
import '../core/models/get_branch.dart';

class BranchProvider extends ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  GetBranch? getBranch;

  List<GetBranch> branchLists = [];


  Future<bool> createBranch({required String name}) async {
    _isLoading = true;
    notifyListeners();

    final token = await TokenStorage.fetchToken();

    try {
      final url = Uri.parse(ApiConst.postGetBranchApi);
      final success = await http.post(url, headers: {
        "accept": "*/*",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      }, body: jsonEncode({"name": name}));
      if (success.statusCode == 200 || success.statusCode == 201) {
        return true;
      } else {
        _errorMessage = "Failed: ${success.statusCode}";
        notifyListeners();
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


  Future<void> getBranches() async {
    _isLoading = true;
    notifyListeners();

    final token = await TokenStorage.fetchToken();

    try {
      final url = Uri.parse(ApiConst.postGetBranchApi);
      final response = await http.get(
          url, headers: {"accept": "*/*", "Authorization": "Bearer $token"});

      if(response.statusCode == 200){
        List<dynamic>jsonList = jsonDecode(response.body);
        branchLists = jsonList.map((e)=> GetBranch.fromJson(e)).toList();
      }
      else{
        _errorMessage = "Failed: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}