import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../utils/utils.dart';

class SignupController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isEnable = false.obs;
  final RxString _roleValue = 'admin'.obs;
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

  List<String> rolesDropdownList = ['admin', 'seller', 'normal'];

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
                setEnable(false);
              }
            } else {
              print(res.error!.message);
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void createAccount() async {
    setLoading(true);

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ParseUser user = ParseUser.createUser(email, password, email);
    if (roleValue.value == 'admin') {
      // ACL for admin
      ParseACL adminACL = ParseACL();
      adminACL.setReadAccess(userId: user.objectId!, allowed: true);
      adminACL.setWriteAccess(userId: user.objectId!, allowed: true);
      user.setACL(adminACL);
      ParseObject products = ParseObject('Products')..setACL(adminACL);
      await products.save();
      ParseObject category = ParseObject('Category')..setACL(adminACL);
      await category.save();
      ParseObject customers = ParseObject('Customers')..setACL(adminACL);
      await customers.save();
      ParseObject sales = ParseObject('Sales')..setACL(adminACL);
      await sales.save();
      ParseObject salesItems = ParseObject('SalesItems')..setACL(adminACL);
      await salesItems.save();
      print('ACL for admin saved');
    } else if (roleValue.value == 'seller') {
      // ACL for seller
      // ParseACL productsACL = ParseACL();
      // productsACL.setReadAccess(allowed: true, userId: user.objectId!);
      // productsACL.setWriteAccess(allowed: true, userId: user.objectId!);
      // user.setACL(productsACL);
      // ParseObject products = ParseObject('Products')..setACL(productsACL);
      // await products.save();
      // print('acl saved for products');
      // ParseObject category = ParseObject('Category')..setACL(sellerACL);
      // await category.save();
      // ParseObject customers = ParseObject('Customers')..setACL(sellerACL);
      // await customers.save();
      // ParseObject sales = ParseObject('Sales')..setACL(sellerACL);
      // await sales.save();
      // ParseObject salesItems = ParseObject('SalesItems')..setACL(sellerACL);
      // await salesItems.save();

      ParseACL sellerACL = ParseACL();
      sellerACL.setPublicWriteAccess(allowed: true);
      sellerACL.setPublicWriteAccess(allowed: false);
      ParseResponse apiResponse = await user.signUp();

      if (apiResponse.success && apiResponse.results != null) {
        ParseObject role = ParseObject('_Role')
          ..set('name', roleValue.value)
          ..addRelation('users', [user])
          ..setACL(sellerACL);
        final ParseResponse response = await role.save();
        if (response.success && response.results != null) {
          setLoading(false);
          Utils.showSnackBarMessage('Success', 'Account Created!', Icons.add_alert);
        } else {
          setLoading(false);
          Utils.showDialogueMessage('Error', response.error!.message, Icons.error_outline_rounded);
          print(response.error!.message);
        }
      } else {
        setLoading(false);
        Utils.showSnackBarMessage('Error', apiResponse.error!.message, Icons.error_outline);
      }
    } else {
      // ACL for normalUser
      ParseACL normalUser = ParseACL();
      normalUser.setPublicReadAccess(allowed: true);
      normalUser.setPublicWriteAccess(allowed: false);
      user.setACL(normalUser);
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
