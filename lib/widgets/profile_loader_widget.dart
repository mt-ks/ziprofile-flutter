import 'package:flutter/material.dart';
import 'package:ziprofile/providers/profile_loader_provider.dart';
import 'package:ziprofile/widgets/loading_dialog.dart';
import 'package:ziprofile/widgets/scaffold_snackbar.dart';

import '../models/user.dart';
import '../screens/app/user_screen.dart';
import 'custom_dialog.dart';

class ProfileLoaderWidget {
  final BuildContext context;
  final BuildContext ctx;
  late LoadingDialog _loadingDialog;
  final User user;
  final navigatorKey;
  ProfileLoaderWidget({
    required this.context,
    required this.ctx,
    required this.user,
    required this.navigatorKey,
  }) {
    _loadingDialog = LoadingDialog(context: context);
    load();
  }

  void _loginRequiredDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Oturumunuz Sona Erdi",
          description: "Tekrar oturum açmanız gerekmektedir.",
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: Text('Oturum Aç'),
            )
          ],
        );
      },
    );
  }

  load() {
    _loadingDialog.showLoaderDialog();

    ProfileLoaderProvider(
      user: user,
      onLoadSuccess: (value) {
        _loadingDialog.hideDialog();
        Navigator.of(ctx).push(
          MaterialPageRoute(
            builder: (ctx) => UserScreen(
              naviagorKey: navigatorKey,
              response: value,
            ),
          ),
        );
      },
      onLoadFailed: (value) {
        _loadingDialog.hideDialog();
        ScaffoldSnackbar(
          context: context,
          message: value,
        );
      },
      onLoginRequired: () {
        _loadingDialog.hideDialog();
        _loginRequiredDialog();
      },
      onOpenNeedSubscription: () {
        _loadingDialog.hideDialog();
        showDialog(
          context: context,
          builder: ((_) {
            return CustomDialog(
              title: "Abonelik Gerekli",
              description:
                  "Bu hizmeti alabilmek için ücretli abonelik satın almanız gerekmektedir.",
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: Text('Abonelik Satın Al'),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
