import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w_sentry/data/model/server_model.dart';
import 'package:w_sentry/data/source/remote/const/api_router.dart';
import 'package:w_sentry/data/source/remote/responses/base_response.dart';
import 'package:w_sentry/data/source/remote/responses/sentry/get_job_detail_response.dart';
import 'package:w_sentry/data/source/remote/responses/sentry/start_sentry_response.dart';
import 'package:w_sentry/data/source/remote/responses/sentry/stop_sentry_response.dart';

part 'sentry_service.g.dart';

@RestApi()
abstract class SentryService {
  factory SentryService(Dio dio, {String baseUrl}) = _SentryService;

  @GET('${ApiRouter.SENTRY}/healths')
  Future<BaseResponse<List<ServerModel>?>> getServerList();

  @GET('{url}')
  Future<BaseResponse<bool?>> checkHealth(@Path('url') String url);

  @POST('${ApiRouter.SENTRY}/start')
  Future<BaseResponse<StartSentryResponseData?>> startSentry();

  @POST('${ApiRouter.SENTRY}/stop')
  Future<BaseResponse<StopSentryResponseData?>> stopSentry();

  @GET('${ApiRouter.SENTRY}/jobs/{id}')
  Future<BaseResponse<GetJobDetailResponseData?>> getJobDetail(@Path('id') int jobId);
}
