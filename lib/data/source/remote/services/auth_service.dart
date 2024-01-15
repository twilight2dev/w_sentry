import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:w_sentry/data/source/remote/const/api_router.dart';
import 'package:w_sentry/data/source/remote/params/auth/email_login_param.dart';
import 'package:w_sentry/data/source/remote/responses/auth/email_login_response.dart';
import 'package:w_sentry/data/source/remote/responses/base_response.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('${ApiRouter.AUTH}/email/login')
  Future<BaseResponse<EmailLoginResponseData>> login(@Body() EmailLoginParam body);
}
