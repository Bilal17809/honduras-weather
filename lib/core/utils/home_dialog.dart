import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '/core/theme/theme.dart';

class HomeDialogs {
  static Future<bool?> showExitDialog(BuildContext context) async {
    return await PanaraConfirmDialog.show(
      context,
      title: 'Exit App',
      message: 'Do you really want to exit the app?',
      confirmButtonText: 'Exit',
      cancelButtonText: 'Cancel',
      onTapConfirm: () => Navigator.pop(context, true),
      onTapCancel: () => Navigator.pop(context, false),
      panaraDialogType: PanaraDialogType.custom,
      color: getSecondaryColor(context),
      barrierDismissible: false,
    );
  }
}