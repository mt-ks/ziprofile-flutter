import 'package:flutter/material.dart';

class ScaffoldSnackbar {
  BuildContext context;
  String message;
  ScaffoldSnackbar({required this.context, required this.message}) {
    _showItem();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showItem() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
