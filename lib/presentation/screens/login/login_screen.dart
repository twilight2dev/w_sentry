import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/common/services/navigator_service.dart';
import 'package:w_sentry/common/utils/validator_utils.dart';
import 'package:w_sentry/presentation/app_router.dart';
import 'package:w_sentry/presentation/base/base_stateful_widget.dart';
import 'package:w_sentry/presentation/screens/login/login_state.dart';
import 'package:w_sentry/presentation/screens/login/login_viewmodel.dart';
import 'package:w_sentry/presentation/shared_widgets/animations/immediate/immediate_slide_animation.dart';
import 'package:w_sentry/presentation/shared_widgets/app_logo.dart';
import 'package:w_sentry/presentation/shared_widgets/button/app_gradient_button.dart';
import 'package:w_sentry/presentation/shared_widgets/clear_focus.dart';
import 'package:w_sentry/presentation/shared_widgets/dialog/confirmation_dialog.dart';
import 'package:w_sentry/presentation/shared_widgets/form_field/app_field.dart';
import 'package:w_sentry/presentation/shared_widgets/form_field/app_form.dart';
import 'package:w_sentry/presentation/shared_widgets/form_field/password_field.dart';
import 'package:w_sentry/presentation/shared_widgets/loading_layer.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_drawable.dart';
import 'package:w_sentry/res/app_typography.dart';

class LoginScreen extends BaseStatefulWidget {
  const LoginScreen({super.key});

  @override
  BaseState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  final GlobalKey<AppFormState> formKey = GlobalKey<AppFormState>();
  LoginViewModel get viewModel => ref.read(loginVMProvider.notifier);

  void listenLoginState() {
    ref.listen(loginVMProvider, (previous, current) {
      if (previous?.status != LoginStatus.success && current.status == LoginStatus.success) {
        context.go(AppScreens.setup_biometric.path, extra: current.loginData);
      }
      if (previous?.status != LoginStatus.failure && current.status == LoginStatus.failure) {
        ref.read(navigatorServiceProvider).openDialog(
          builder: (context) {
            return ConfirmationDialog(
              title: 'Login Failed',
              content: const Text('Oops! Your login attempt failed. Please check your email and password'),
              confirmLabel: 'Try again',
              onConfirm: () {},
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listenLoginState();
    final state = ref.watch(loginVMProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    return LoadingLayer(
      visible: state.status == LoginStatus.loading,
      child: ClearFocusScaffold(
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(PaddingDefault.large),
          physics: const BouncingScrollPhysics(),
          child: AppForm(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.15),
                const ImmediateSlideAnimation(
                  duration: Duration(milliseconds: 800),
                  begin: Offset(-0.5, 0),
                  end: Offset(0, 0),
                  child: AppLogo(),
                ),
                // const AppLogo(),
                ImmediateSlideAnimation(
                  duration: const Duration(milliseconds: 800),
                  begin: const Offset(-0.5, 0),
                  end: const Offset(0, 0),
                  child: Text(
                    'Welcome Back. Securely Access Your Account',
                    textAlign: TextAlign.center,
                    style: AppTypography.poppins_14px_w500.withColor(AppColors.contentText),
                  ),
                ),
                const SizedBox(height: 40),
                ImmediateSlideAnimation(
                  duration: const Duration(milliseconds: 400),
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                  child: _buildUsernameField(),
                ),
                const SizedBox(height: 20),
                ImmediateSlideAnimation(
                  duration: const Duration(milliseconds: 600),
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                  child: _buildPasswordField(),
                ),
                // _buildPasswordField(),
                const SizedBox(height: 20),
                ImmediateSlideAnimation(
                  duration: const Duration(milliseconds: 800),
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                  child: _buildLoginButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return AppFormField(
      hintText: 'Email',
      isRequired: true,
      // autofocus: true,
      onSaved: viewModel.updateUserName,
      fieldValidator: ValidatorUtils.emailValidator,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: SvgPicture.asset(AppDrawable.ic_person_svg),
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      hintText: 'Password',
      onSaved: viewModel.updatePassword,
    );
  }

  AppFilledButton _buildLoginButton() {
    return AppFilledButton(
      label: 'Log in',
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          viewModel.login();
        }
      },
    );
  }
}
