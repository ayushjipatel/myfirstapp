import 'package:firstapp/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Logout',
    content: 'Are you sure you want to logout?',
    optionBuilder: () => {
      'Cancle': false,
      'Log Out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
