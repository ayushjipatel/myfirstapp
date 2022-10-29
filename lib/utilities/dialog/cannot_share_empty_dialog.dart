import 'package:firstapp/utilities/dialog/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showCannotShareEmptyNoteDilog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing ',
    content: 'You cannot share empty dilog',
    optionBuilder: () => {
      'ok': null,
    },
  );
}
