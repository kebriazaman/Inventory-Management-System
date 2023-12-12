import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/utils.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;
  final signupFormKey = GlobalKey<FormState>();
  var obscurePassword = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode createAccButtonFocusNode = FocusNode();

  void userSignup(BuildContext context) async {
    isLoading.value = true;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ParseUser user = ParseUser.createUser(email, password, email);

    // ParseACL parseACL = ParseACL();
    // parseACL.setPublicReadAccess(allowed: true);
    // parseACL.setPublicWriteAccess(allowed: true);
    // user.setACL(parseACL);

    ParseResponse apiResponse = await user.signUp();
    if (apiResponse.success && apiResponse.results != null) {
      isLoading.value = false;
      Get.offNamed(RouteName.desktopScreen);
    } else {
      isLoading.value = false;
      Utils.showDialogueBox(context, 'Error', apiResponse.error!.message, Icon(Icons.cloud_off_rounded));
    }
  }

  void setUserACL() async {
    ParseACL parseACL = ParseACL();
    parseACL.setPublicReadAccess(allowed: true);
    parseACL.setPublicWriteAccess(allowed: true);

    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Role'));

    final queryResponse = await queryBuilder.query();

    ParseObject role = ParseObject('Role');

    var apiResponse = await role.save();
    if (apiResponse.success) {
      print(apiResponse.success);
    } else {
      print(apiResponse.error!.message);
    }
  }
}
