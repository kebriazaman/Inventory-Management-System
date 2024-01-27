import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../utils/utils.dart';

class SignupController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isEnable = false.obs;
  final RxString _roleValue = 'select'.obs;
  final RxBool _isMatched = true.obs;
  final signupFormKey = GlobalKey<FormState>();
  var obscurePassword = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode createAccButtonFocusNode = FocusNode();

  RxBool get isEnable => _isEnable;
  RxBool get isLoading => _isLoading;
  RxString get roleValue => _roleValue;
  RxBool get isMatched => _isMatched;

  setEnable(bool v) => _isEnable.value = v;
  setLoading(bool v) => _isLoading.value = v;
  setRoleValue(String v) => _roleValue.value = v;
  setMatched(bool v) => _isMatched.value = v;

  List<String> rolesDropdownList = ['select', 'seller', 'normal'];

  Future<void> checkEmail(String email) async {
    if (email.isNotEmpty) {
      setMatched(false);
      final QueryBuilder<ParseObject> queryBuilder = QueryBuilder<ParseObject>(ParseObject('_Role'));
      try {
        ParseResponse response = await queryBuilder.query();
        if (response.success && response.results != null) {
          for (ParseObject obj in response.results!) {
            ParseRelation rel = obj['users'];
            var o = rel.getQuery()..includeObject(['_User']);
            var res = await o.query();
            if (res.success && res.results != null) {
              ParseObject relObj = res.results!.first;
              if (relObj['username'] == email) {
                setMatched(true);
                setEnable(true);
              } else {
                setMatched(true);
                setEnable(true);
              }
            } else {
              setMatched(false);
              setEnable(false);
            }
          }
        } else {
          print(response.error!.message);
        }
      } catch (e) {
        print(e);
      }
      print(isEnable.value);
    }
  }

  void createAccount() async {
    setLoading(true);
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ParseUser user = ParseUser.createUser(email, password, email);
    ParseResponse apiResponse = await user.signUp();

    if (apiResponse.success && apiResponse.results != null) {
      if (roleValue.value == 'seller') {
        ParseACL sellerACL = ParseACL();
        sellerACL.setReadAccess(userId: user.objectId!, allowed: true);
        sellerACL.setWriteAccess(userId: user.objectId!, allowed: true);
        ParseObject role = ParseObject('_Role')
          ..set('name', roleValue.value)
          ..addRelation('users', [user])
          ..setACL(sellerACL);
        final ParseResponse response = await role.save();
        print(response.success);
        if (response.success && response.results != null) {
          setLoading(false);
          Utils.showSnackBarMessage('Success', 'Account Created!', Icons.add_alert);
        } else {
          setLoading(false);
          Utils.showDialogueMessage('Error', response.error!.message, Icons.error_outline_rounded);
        }
      } else if (roleValue.value == 'normal') {
        ParseACL sellerACL = ParseACL();
        sellerACL.setReadAccess(userId: user.objectId!, allowed: true);
        sellerACL.setWriteAccess(userId: user.objectId!, allowed: true);
        ParseObject role = ParseObject('_Role')
          ..set('name', roleValue.value)
          ..addRelation('users', [user])
          ..setACL(sellerACL);
        final ParseResponse response = await role.save();
        print(response.success);
        print(response.results);
        if (response.success && response.results != null) {
          setLoading(false);
          Utils.showSnackBarMessage('Success', 'Account Created!', Icons.add_alert);
        } else {
          setLoading(false);
          print(response.error!.message + 'sldkfjsldjfsldkjf');
          // Utils.showDialogueMessage('Error', response.error!.message, Icons.error_outline_rounded);
        }
      }
    } else {
      setLoading(false);
      print(apiResponse.error!.message);
      // Utils.showSnackBarMessage('Error', apiResponse.error!.message, Icons.error_outline);
    }
  }
}
