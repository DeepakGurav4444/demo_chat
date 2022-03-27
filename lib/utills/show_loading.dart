import 'package:flutter/material.dart';

import '../dialog/waiting_dialog.dart';

class ShowLoading {
  static Future<void> showLoading(BuildContext context) async {
    return showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.6),
        builder: (context) => const WaitingDialog(),
        barrierDismissible: false);
  }
}