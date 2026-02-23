import 'package:fintesthub_flutter/domain/common/result.dart';

import '../models/setting.dart';

abstract class SettingsRepository {

  Future<Result<Setting>> getSetting(Setting setting);

  Future<Result<void>> saveSetting(Setting setting);
}