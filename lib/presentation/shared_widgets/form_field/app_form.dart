// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:w_sentry/common/extensions/context_ext.dart';
import 'package:w_sentry/presentation/shared_widgets/form_field/app_field.dart';

class AppForm extends Form {
  const AppForm({
    super.key,
    required super.child,
    super.onChanged,
    super.onWillPop,
  }) : super(autovalidateMode: AutovalidateMode.disabled);

  @override
  FormState createState() => AppFormState();
}

class AppFormState extends FormState {
  @override
  bool validate({bool scrollToInvalid = true}) {
    final isValidate = super.validate();
    if (isValidate) {
      FocusManager.instance.primaryFocus?.unfocus();
      save();
    } else if (scrollToInvalid) {
      _scrollToFirstInvalidField();
    }

    return isValidate;
  }

  void _scrollToFirstInvalidField() {
    final formFields = context.findAllDescendantWidgetsOfExactType<AppFormField>();
    final firstInvalidField = formFields.firstWhereOrNull((field) {
      final formFieldKey = field.key;
      return formFieldKey is GlobalKey<FormFieldState> &&
          formFieldKey.currentState is AppFormFieldState &&
          formFieldKey.currentState?.isValid == false;
    });

    final firstInvalidFieldKey = firstInvalidField?.key as GlobalKey<FormFieldState>?;
    final firstInvalidFieldContext = firstInvalidFieldKey?.currentContext;
    if (firstInvalidField != null && firstInvalidFieldKey != null && firstInvalidFieldContext != null) {
      Scrollable.ensureVisible(
        firstInvalidFieldContext,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
