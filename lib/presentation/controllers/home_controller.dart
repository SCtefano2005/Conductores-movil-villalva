import 'package:flutter/material.dart';
import '../../core/utils/secure_storage_service.dart';
import '../../data/models/user_model.dart';
import '../../core/utils/app_navigator.dart';

class HomeController extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  bool _loading = true;
  bool get loading => _loading;

  Future<void> loadUser() async {
    _loading = true;
    notifyListeners();

    _user = await SecureStorageService.getUser();

    _loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await SecureStorageService.clearAll();
    AppNavigator.navigateToLogin();
  }
}
