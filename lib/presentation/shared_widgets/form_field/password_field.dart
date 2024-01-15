import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:w_sentry/common/utils/validator_utils.dart';
import 'package:w_sentry/presentation/shared_widgets/form_field/app_field.dart';
import 'package:w_sentry/res/app_drawable.dart';
import 'package:w_sentry/res/app_typography.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onSaved, this.hintText, this.label, this.showPrefixIcon = true});

  final Function(String?)? onSaved;
  final String? hintText;
  final String? label;
  final bool showPrefixIcon;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final controller = TextEditingController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      controller: controller,
      label: widget.label,
      hintText: widget.hintText,
      isRequired: true,
      obscureText: !visible,
      onSaved: widget.onSaved,
      fieldValidator: ValidatorUtils.passwordValidator,
      prefixIcon: widget.showPrefixIcon ? SvgPicture.asset(AppDrawable.ic_lock_svg) : null,
      suffixIcon: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, snapshot, child) {
          return Visibility(
            visible: snapshot.text.isNotEmpty,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              child: Text(
                visible ? 'Hide' : 'Show',
                textAlign: TextAlign.center,
                style: AppTypography.poppins_14px_w400,
              ),
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
