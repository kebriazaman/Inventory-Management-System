import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/utils/utils.dart';

class ResetPasswordController extends GetxController {
  Timer? textTimer, visibilityTimer;

  final RxBool _isLoading = false.obs;
  final RxBool _isWatching = false.obs;
  final RxBool _isVisible = false.obs;

  RxBool get isLoading => _isLoading;
  RxBool get isWatching => _isWatching;

  RxBool get isVisible => _isVisible;

  setLoading(bool v) => _isLoading.value = v;
  setVisibility(bool v) => _isVisible.value = v;
  setWatching(bool v) => _isWatching.value = v;

  FocusNode resetPasswordFocusNode = FocusNode();
  FocusNode resetButtonFocusNode = FocusNode();
  TextEditingController resetPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    setLoading(true);
    try {
      final ParseUser user = ParseUser(null, null, resetPasswordController.text.trim());
      final ParseResponse parseResponse = await user.requestPasswordReset();
      if (parseResponse.success) {
        setLoading(false);
        Utils.showSnackBarMessage('Success', 'Email has been sent', Icons.add_alert);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  Future<void> watchPassword(String email) async {
    setWatching(true);
    QueryBuilder<ParseUser> queryUsers = QueryBuilder<ParseUser>(ParseUser.forQuery());
    final response = await queryUsers.query();
    if (response.success && response.results != null) {
      for (ParseUser user in response.results!) {
        if (email == user['username']) {
          setVisibility(true);
          setWatching(false);
          visibilityTimer = Timer(const Duration(seconds: 1), () => setVisibility(false));
          return;
        } else {
          setVisibility(false);
        }
      }
    }
  }

  void checkTimers() {
    if (textTimer != null && textTimer!.isActive) {
      textTimer!.cancel();
    }
    if (visibilityTimer != null && visibilityTimer!.isActive) {
      visibilityTimer!.cancel();
    }
  }
}
