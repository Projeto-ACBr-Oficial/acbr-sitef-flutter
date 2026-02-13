
import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  bool _isReadyToNavigate = false;
  bool get isReadyToNavigate => _isReadyToNavigate;

  Future<void> validateAndProceed() async {
    await Future.delayed(const Duration(seconds: 2));

    _isReadyToNavigate = true;
    notifyListeners();
  }
}