import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/common/services/navigator_service.dart';
import 'package:w_sentry/data/repository/base/repo_result.dart';
import 'package:w_sentry/data/source/remote/exceptions/api_exception.dart';
import 'package:w_sentry/data/source/remote/responses/base_response.dart';

abstract class BaseRepository {
  Ref get ref;

  // Apis follow the rules of base response
  Future<RepoResult<T?>> safeCallApi<T>(
    Future<BaseResponse<T?>> request, {
    bool autoHandleError = true,
  }) async {
    try {
      final response = await request;
      return _handleBaseResponse(response);
    } catch (exception, stackTrace) {
      log(' ---- TRACE: $stackTrace\n---- EXCEPTION: $exception');
      final e = _handleException(exception, autoHandleError: autoHandleError);
      return RepoResult.failure(error: e);
    }
  }

  Future<RepoResult<T?>> _handleBaseResponse<T>(BaseResponse<T?> response) async {
    if (response.isSuccessed) {
      return RepoResult.success(data: response.data);
    } else {
      return RepoResult.failure(error: response.exception);
    }
  }

  ApiException _handleException<T>(dynamic e, {bool autoHandleError = true}) {
    final exception = ApiException.parse(e);
    final isCancelRequest = exception is CancelledException;
    if (exception is ServiceUnavailableException) {
      // logout
    } else if (autoHandleError && !isCancelRequest) {
      ref.read(navigatorServiceProvider).showErrorDialog(exception);
    }
    return exception;
  }
}
