import 'dart:async';

import 'package:flutter/material.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/screens/home/home_state.dart';
import 'package:w_sentry/presentation/screens/home/home_viewmodel.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';
import 'package:w_sentry/presentation/shared_widgets/button/logout_button.dart';
import 'package:w_sentry/presentation/shared_widgets/loading_layer.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({super.key});

  @override
  BaseState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  Timer? _biometricAuthTimer;
  Timer? _healthCheckTimer;

  HomeViewModel get viewModel => ref.read(homeVMProvider.notifier);

  @override
  void initState() {
    super.initState();
    _biometricAuthTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      ref.read(routerProvider).go(AppScreens.verify_biometric.path);
    });
    _healthCheckTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      viewModel.checkHealth();
    });
  }

  @override
  void onViewCreated() {
    super.onViewCreated();
    viewModel.init();
  }

  @override
  void dispose() {
    _biometricAuthTimer?.cancel();
    _healthCheckTimer?.cancel();
    super.dispose();
  }

  void listenHomeState() {
    ref.listen(homeVMProvider, (previous, current) {
      if (current.status == HomeStatus.start_server_success) {
        showSuccessMessage('Start Successfully');
      }
      if (current.status == HomeStatus.stop_server_success) {
        showSuccessMessage('Stop Successfully');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listenHomeState();
    final state = ref.watch(homeVMProvider);
    return LoadingLayer(
      visible: state.isLoading,
      desc: state.loadingMessage,
      child: Scaffold(
        appBar: AppBar(
          title: const AppLogo(size: 18),
          actions: const [LogoutButton()],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingDefault.large),
          child: LayoutBuilder(builder: (context, constraints) {
            final maxWidth = constraints.biggest.width;
            final buttonWidth = (maxWidth - 20) / 2;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 18),
                const Text('Server Status', style: AppTypography.poppins_14px_w600),
                const SizedBox(height: 10),
                StatusCard(isActive: true, quantity: state.activeServers.length),
                const SizedBox(height: 10),
                StatusCard(isActive: false, quantity: state.inActiveServers.length),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ControlButton(
                      size: buttonWidth,
                      label: 'Stop',
                      onPressed: viewModel.stopServer,
                      color: AppColors.redFF3654,
                    ),
                    const SizedBox(width: 20),
                    ControlButton(
                      size: buttonWidth,
                      label: 'Start',
                      onPressed: viewModel.startServer,
                      color: AppColors.green6DC965,
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.isActive,
    required this.quantity,
  });

  final bool isActive;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              isActive ? 'Active' : 'Non Active',
              style: AppTypography.poppins_14px_w600.withColor(isActive ? AppColors.primary : Colors.grey),
            ),
            const Spacer(),
            Text('$quantity', style: AppTypography.poppins_14px_w600),
          ],
        ),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  const ControlButton({
    super.key,
    required this.label,
    required this.size,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final double size;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
          colors: [color.withOpacity(0.75), color.withOpacity(0.5), color.withOpacity(0.25)],
        ),
      ),
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        elevation: 10.0,
        fillColor: color,
        padding: const EdgeInsets.all(18.0),
        child: Text(
          label,
          style: AppTypography.poppins_20px_w700.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
