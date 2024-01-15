// ignore_for_file: sdk_version_since

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/model/server_model.dart';
import 'package:w_sentry/data/repository/base/base_repository.dart';
import 'package:w_sentry/data/repository/base/repo_result.dart';
import 'package:w_sentry/data/source/remote/responses/sentry/get_job_detail_response.dart';
import 'package:w_sentry/data/source/remote/responses/sentry/start_sentry_response.dart';
import 'package:w_sentry/data/source/remote/responses/sentry/stop_sentry_response.dart';
import 'package:w_sentry/data/source/remote/services/sentry_service.dart';

class SentryRepository extends BaseRepository {
  @override
  final Ref ref;
  final SentryService sentryService;

  SentryRepository({required this.sentryService, required this.ref});

  Future<RepoResult<List<ServerModel>?>> getServerList() async {
    return safeCallApi(sentryService.getServerList());
  }

  Future<RepoResult<bool?>> checkHealth(String serverUrl) async {
    return safeCallApi(sentryService.checkHealth(serverUrl));
  }

  Future<RepoResult<StartSentryResponseData?>> startServer() async {
    return safeCallApi(sentryService.startSentry());
  }

  Future<RepoResult<StopSentryResponseData?>> stopServer() async {
    return safeCallApi(sentryService.stopSentry());
  }

  Future<RepoResult<GetJobDetailResponseData?>> getJobDetail(int jobId) async {
    return safeCallApi(sentryService.getJobDetail(jobId));
  }
}
