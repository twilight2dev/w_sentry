import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:w_sentry/common/extensions/extensions.dart';
import 'package:w_sentry/common/extensions/text_style_ext.dart';
import 'package:w_sentry/common/utils/validator_utils.dart';
import 'package:w_sentry/res/app_colors.dart';
import 'package:w_sentry/res/app_dimens.dart';
import 'package:w_sentry/res/app_typography.dart';

class AppFormField extends FormField<String> {
  AppFormField({
    super.enabled = true,
    super.initialValue,
    super.onSaved,
    this.autofocus = false,
    this.contentPadding,
    this.controller,
    this.enableInteractiveSelection = true,
    this.errorBuilder,
    this.fieldValidator,
    this.fieldBuilder,
    this.fieldKey,
    this.hintStyle,
    this.hintText,
    this.inputFormatters,
    this.isRequired = false,
    this.keyboardType,
    this.label,
    this.labelBuilder,
    this.labelStyle,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onTapOutside,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.readOnly = false,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.radius = AppDimens.radius,
  }) : super(
          key: fieldKey,
          validator: isRequired
              ? fieldValidator ??
                  (value) => ValidatorUtils.requiredFieldValidator(value, fieldLabel: label ?? 'This field')
              : fieldValidator ?? ValidatorUtils.noValidator,
          builder: fieldBuilder ??
              (fieldState) {
                if (fieldState is! AppFormFieldState) {
                  return const SizedBox();
                }

                final errorText = fieldState.errorText;

                void onChangeHandler(String value) {
                  fieldState.didChange(value);
                  onChanged?.call(value);
                }

                Widget buildDefaultLabel() {
                  if (label.isNullOrEmpty) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      label!,
                      style: labelStyle ??
                          AppTypography.poppins_14px_w400.withColor(
                            AppColors.contentText.withOpacity(0.7),
                          ),
                    ),
                  );
                }

                Widget buildDefaultError() {
                  if (errorText.isNullOrEmpty) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 2, left: 4),
                    child: Text(
                      fieldState.errorText!,
                      style: labelStyle ?? AppTypography.poppins_12px_w400.withColor(AppColors.redFF3654),
                    ),
                  );
                }

                Widget buildTextField() {
                  return TextField(
                    controller: fieldState.effectiveController,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    textCapitalization: textCapitalization,
                    autofocus: autofocus,
                    readOnly: readOnly,
                    obscureText: obscureText,
                    inputFormatters: inputFormatters,
                    onTap: onTap,
                    onTapOutside: onTapOutside,
                    onChanged: onChangeHandler,
                    maxLength: maxLength,
                    style: AppTypography.poppins_14px_w500.copyWith(
                      color: AppColors.contentText,
                    ),
                    maxLines: maxLines,
                    enabled: enabled,
                    onSubmitted: onSubmitted,
                    enableInteractiveSelection: enableInteractiveSelection,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      isCollapsed: true,
                      counterText: '',
                      hintText: hintText ?? 'Enter ${label ?? ""}',
                      hintStyle: hintStyle ??
                          AppTypography.poppins_14px_w400.copyWith(
                            color: AppColors.contentText,
                          ),
                      prefixIcon: prefixIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 18, right: 8),
                              child: prefixIcon,
                            )
                          : null,
                      prefixIconConstraints: prefixIconConstraints,
                      suffixIcon: suffixIcon != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8, right: 18),
                              child: suffixIcon,
                            )
                          : null,
                      suffixIconConstraints: suffixIconConstraints,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                        borderSide: BorderSide(
                          color: errorText.isNullOrEmpty ? AppColors.textFieldBorder : AppColors.redFF3654,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                        borderSide: BorderSide(
                          color: errorText.isNullOrEmpty ? AppColors.primary : AppColors.redFF3654,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: 1,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                        borderSide: BorderSide(
                          color: AppColors.textFieldBorder.withOpacity(0.2),
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: 1,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldBackground,
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    labelBuilder?.call(label) ?? buildDefaultLabel(),
                    buildTextField(),
                    errorBuilder?.call(fieldState.errorText) ?? buildDefaultError(),
                  ],
                );
              },
        );

  final bool autofocus;
  final bool enableInteractiveSelection;
  final bool isRequired;
  final bool obscureText;
  final bool readOnly;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? contentPadding;
  final FormFieldBuilder<String>? fieldBuilder;
  final FormFieldValidator<String>? fieldValidator;
  final GestureTapCallback? onTap;
  final GlobalKey<FormFieldState>? fieldKey;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? label;
  final TapRegionCallback? onTapOutside;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget Function(String? error)? errorBuilder;
  final Widget Function(String? label)? labelBuilder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;

  @override
  FormFieldState<String> createState() => AppFormFieldState();
}

class AppFormFieldState extends FormFieldState<String> {
  final RestorableStringN _overrideErrorText = RestorableStringN(null);
  RestorableTextEditingController? _controller;
  bool _hasFirstTimeValidated = false;

  TextEditingController? get effectiveController => _formField.controller ?? _controller?.value;

  AppFormField get _formField => super.widget as AppFormField;

  @override
  String? get errorText => _overrideErrorText.value;

  @override
  bool get hasError => _overrideErrorText.value != null && _overrideErrorText.value?.isNotEmpty == true;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_overrideErrorText, 'override_error_text');
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    setValue(effectiveController?.text);
  }

  void _registerController() {
    final cloneController = _controller;
    if (cloneController != null) {
      registerForRestoration(cloneController, 'controller');
    }
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_formField.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue ?? '') : null);
    } else {
      _formField.controller?.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_formField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _formField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _formField.controller == null) {
        _createLocalController(oldWidget.controller?.value);
      }

      if (_formField.controller != null) {
        setValue(_formField.controller?.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller?.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled && _hasFirstTimeValidated && widget.autovalidateMode == AutovalidateMode.disabled) {
      _validate();
    }
    return super.build(context);
  }

  @override
  void dispose() {
    _formField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (effectiveController?.text != value) {
      effectiveController?.text = value ?? '';
    }
  }

  @override
  void reset() {
    _hasFirstTimeValidated = false;
    _overrideErrorText.value = null;
    effectiveController?.text = widget.initialValue ?? '';
    super.reset();
  }

  @override
  bool validate() {
    _hasFirstTimeValidated = true;
    setState(() => _validate());
    return !hasError;
  }

  void _validate() {
    if (widget.validator != null) {
      _overrideErrorText.value = widget.validator!(value);
    }
  }

  void _handleControllerChanged() {
    if (effectiveController?.text != value) {
      didChange(effectiveController?.text);
    }
  }
}
