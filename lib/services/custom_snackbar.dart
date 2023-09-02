import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/theme/app_colors.dart';

class CustomSnackbarService {
  static final CustomSnackbarService _instance =
      CustomSnackbarService._internal();

  factory CustomSnackbarService() {
    return _instance;
  }

  CustomSnackbarService._internal();

  static final GlobalKey<ScaffoldMessengerState> _rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get rootScaffoldMessengerKey =>
      _rootScaffoldMessengerKey;

  void showErrorSnackbar(String? message) {
    _rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    SnackBar errorSnackbar = SnackBar(
      content: Text(
        message ?? "Something went wrong!",
        style: const TextStyle(
          color: AppColor.onError,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1,
        ),
      ),
      backgroundColor: AppColor.error,
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    _rootScaffoldMessengerKey.currentState?.showSnackBar(errorSnackbar);
  }

  void showSuccessSnackbar(String? message) {
    _rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    SnackBar snackbar = SnackBar(
      content: Text(
        message ?? "Success!",
        style: const TextStyle(
          color: AppColor.onSuccess,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1,
        ),
      ),
      backgroundColor: AppColor.success,
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    _rootScaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  void showInfoSnackbar(String? message) {
    _rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    SnackBar snackbar = SnackBar(
      content: Text(
        message ?? "Info...",
        style: const TextStyle(
          color: AppColor.onInfo,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1,
        ),
      ),
      backgroundColor: AppColor.info,
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    _rootScaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  void showWarningSnackbar(String? message) {
    _rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    SnackBar snackbar = SnackBar(
      content: Text(
        message ?? "Warning...",
        style: const TextStyle(
          color: AppColor.onWarning,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1,
        ),
      ),
      backgroundColor: AppColor.warning,
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    _rootScaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  void hideCurrentSnackbar() {
    _rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }
}
