import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:w_sentry/common/utils/system_utils.dart';
import 'package:w_sentry/data/source/local/storage/local_storage.dart';
import 'package:w_sentry/presentation/app.dart';

Future<void> main() async {
  await _setup();
  final localStorage = LocalStorage();
  await localStorage.initialize();

  runApp(
    ProviderScope(
      overrides: [
        localStorageProvider.overrideWithValue(localStorage),
      ],
      child: const Application(),
    ),
  );
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Hive.initFlutter(),
    SystemUtils.setStatusBarLight(),
    SystemUtils.setOrientationPortrait(),
  ]);
  SystemUtils.setStatusBarTransparent();
}
