import 'package:firstapp/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error occured ',
    content: text,
    optionBuilder: () => {
      "ok": null,
    },
  );
}
