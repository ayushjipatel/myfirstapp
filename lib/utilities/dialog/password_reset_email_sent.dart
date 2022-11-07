import 'package:firstapp/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'password reset ',
    content:
        'We have sent you a password reset link. Please check your email for more information',
    optionBuilder: () => {
      'ok': null,
    },
  );
}
