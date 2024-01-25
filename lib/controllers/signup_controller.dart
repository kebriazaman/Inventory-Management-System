import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class SignupController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _roleValue = 'admin'.obs;
  final signupFormKey = GlobalKey<FormState>();
  var obscurePassword = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode createAccButtonFocusNode = FocusNode();

  RxBool get isLoading => _isLoading;
  RxString get roleValue => _roleValue;

  setLoading(bool v) => _isLoading.value = v;
  setRoleValue(String v) => _roleValue.value = v;

  List<String> rolesDropdownList = ['admin', 'seller', 'normal'];

  Future<void> checkEmail(String email) async {
    final QueryBuilder<ParseObject> queryBuilder = QueryBuilder<ParseObject>(ParseObject('_Role'));
    try {
      ParseResponse response = await queryBuilder.query();
      if (response.success && response.results != null) {
        for (ParseObject obj in response.results!) {
          ParseRelation rel = obj['users'];
          var o = rel.getQuery()..includeObject(['_User']);
          var res = await o.query();
          print(res.results);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void createAccount() async {
    setLoading(true);

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ParseUser user = ParseUser.createUser(email, password, email);

    // ACL for admin
    ParseACL adminACL = ParseACL();
    adminACL.setPublicReadAccess(allowed: true);
    adminACL.setPublicWriteAccess(allowed: true);
    user.setACL(adminACL);

    // ACL for seller
    ParseACL sellerACL = ParseACL();
    sellerACL.setReadAccess(allowed: true, userId: user.objectId!);
    sellerACL.setWriteAccess(allowed: true, userId: user.objectId!);
    user.setACL(sellerACL);

    // ACL for normalUser
    ParseACL normalUser = ParseACL();
    normalUser.setPublicReadAccess(allowed: true);
    normalUser.setPublicWriteAccess(allowed: false);
    user.setACL(normalUser);

    ParseResponse apiResponse = await user.signUp();

    QueryBuilder<ParseObject> queryBuilder = QueryBuilder<ParseObject>(ParseObject('_Role'));
    ParseResponse roleResponse = await queryBuilder.query();
    if (roleResponse.success && roleResponse.results != null) {
      final role = roleResponse.results!;
      for (ParseObject r in role) {
        print(r['name']);
      }
    }

    // if (apiResponse.success && apiResponse.results != null) {
    //   ParseObject role = ParseObject('_Role')
    //     ..set('name', 'seller')
    //     ..addRelation('users', [user])
    //     ..setACL(adminACL);
    //   final ParseResponse response = await role.save();
    //   if (response.success && response.results != null) {
    //     setLoading(false);
    //     Utils.showSnackBarMessage('Success', 'You have successfully Signed Up', Icons.add_alert);
    //     Get.offNamed(RouteName.mainScreen);
    //   } else {
    //     print(response.error!.message);
    //   }
    // } else {
    //   setLoading(false);
    //   Utils.showSnackBarMessage('Error', apiResponse.error!.message, Icons.error_outline);
    // }
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
