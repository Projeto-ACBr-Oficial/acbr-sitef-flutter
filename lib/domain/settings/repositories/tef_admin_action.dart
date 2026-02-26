import 'package:fintesthub_flutter/domain/common/result.dart';
import 'package:fintesthub_flutter/domain/settings/models/admin_response.dart';

abstract class TefAdminAction {

  Future<Result<AdminResponse>> openAdminMenu();
}