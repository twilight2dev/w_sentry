import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/repository/auth_repository.dart';
import 'package:w_sentry/data/repository/sentry_repository.dart';
import 'package:w_sentry/data/source/remote/services/services.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(ref: ref, authService: ref.watch(authServiceProvider)),
);

final sentryRepositoryProvider = Provider(
  (ref) => SentryRepository(ref: ref, sentryService: ref.watch(sentryServiceProvider)),
);
