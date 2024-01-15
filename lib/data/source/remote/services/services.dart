import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/source/remote/api_client.dart';
import 'package:w_sentry/data/source/remote/services/auth_service.dart';
import 'package:w_sentry/data/source/remote/services/sentry_service.dart';

final authServiceProvider = Provider((ref) => AuthService(ref.watch(apiV1ClientProvider).dio));
final sentryServiceProvider = Provider((ref) => SentryService(ref.watch(apiV1ClientProvider).dio));
