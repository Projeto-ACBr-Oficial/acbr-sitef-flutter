import 'package:fintesthub_flutter/core/config/app_defaults.dart';
import 'package:fintesthub_flutter/data/settings/local_settings_repository.dart';
import 'package:fintesthub_flutter/domain/settings/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  bool _isReadyToNavigate = false;

  bool get isReadyToNavigate => _isReadyToNavigate;

  Future<void> validateAndProceed() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await Settings.init(repository: LocalSettingsRepository(prefs),
          defaultSettings: sitefDefaultSettings);
    } catch (e) {
      debugPrint("Erro ao carregar configurações: $e");
    } finally {
      _isReadyToNavigate = true;
      notifyListeners();
    }
  }
}