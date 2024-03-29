import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/shared_providers/auth/auth_viewmodel.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      padding: const EdgeInsets.only(right: 18),
      minSize: 0,
      child: const Icon(Icons.logout_outlined),
      onPressed: () {
        ref.read(authVMProvider.notifier).logout();
        context.go(AppScreens.login.path);
      },
    );
  }
}
