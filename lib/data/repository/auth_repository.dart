// ignore_for_file: sdk_version_since

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/repository/base/base_repository.dart';
import 'package:w_sentry/data/repository/base/repo_result.dart';
import 'package:w_sentry/data/source/remote/params/auth/email_login_param.dart';
import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';
import 'package:w_sentry/data/source/remote/services/auth_service.dart';

class AuthRepository extends BaseRepository {
  @override
  final Ref ref;
  final AuthService authService;

  AuthRepository({required this.authService, required this.ref});

  Future<RepoResult<EmailLoginResponseData?>> login(EmailLoginParam param) async {
    return safeCallApi(authService.login(param), autoHandleError: false);
  }
}
