import 'package:firstapp/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to Delete ?',
    optionBuilder: () => {
      'Cancle': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
