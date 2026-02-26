import 'package:fintesthub_flutter/data/msitef/admin/msitef_admin_mapper.dart';
import 'package:fintesthub_flutter/domain/settings/models/admin_response.dart';
import 'package:fintesthub_flutter/domain/settings/repositories/tef_admin_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/common/result.dart';

class MsitefAdminAction extends TefAdminAction {
  static const _channel = MethodChannel('com.mjtech.fintesthub.flutter/msitef');

  @override
  Future<Result<AdminResponse>> openAdminMenu() async {
    try {
      final map = MsitefAdminMapper.toMap();

      final result = await _channel.invokeMethod('admin', map);

      return _parseResult(result);
    } on PlatformException catch (_) {
      return Future.value(Result.failure("Erro de comunicação com o sistema"));
    } catch (e) {
      return Future.value(Result.failure(e.toString()));
    }
  }

  Result<AdminResponse> _parseResult(dynamic result) {
    debugPrint("Native Admin Result: $result");

    if (result == null || result is! Map) {
      return Result.failure("Resposta inválida do sistema nativo");
    }

    final String? status = result['status']?.toString();

    return switch (status) {
      'SUCCESS' => Result.success(
        AdminResponse(
          action: result['action'] ?? "",
          receipt: result['receipt'] ?? "",
        ),
      ),
      'FAILURE' => Result.failure(
        result['errorMessage'] ?? 'Erro na operação administrativa',
      ),
      'CANCELLED' => Result.failure("Operação cancelada"),
      _ => Result.failure("Erro inesperado: $status"),
    };
  }
}
