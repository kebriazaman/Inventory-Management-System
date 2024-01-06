import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/customers_model.dart';

class CustomerController extends GetxController {
  final RxBool _isCustomerLoading = false.obs;
  final RxString _customer = ''.obs;

  final RxList<CustomersModel> customers = <CustomersModel>[].obs;
  final GlobalKey<FormBuilderState> customerFormKey = GlobalKey<FormBuilderState>();

  RxBool get isCustomerLoading => _isCustomerLoading;
  RxString get customer => _customer;

  setCustomerLoading(bool value) => _isCustomerLoading.value = value;
  setCustomerValue(String value) => _customer.value = value;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController customerEditingController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  FocusNode saveButtonFocusNode = FocusNode();

  Future<List<CustomersModel>> fetchAllCustomers(String customerName) async {
    QueryBuilder<ParseObject> customerQuery = QueryBuilder(ParseObject('Customers'))..orderByDescending('createdAt');
    ParseResponse queryResponse = await customerQuery.query();
    if (queryResponse.success && queryResponse.results != null) {
      dynamic decodedData = jsonDecode(queryResponse.results.toString());
      return (decodedData as List).map((e) => CustomersModel.fromJson(e)).where((element) {
        return element.name!.toLowerCase().contains(customerName.toLowerCase());
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> saveCustomer() async {
    setCustomerLoading(true);
    try {
      ParseObject customerType = ParseObject('Customers')
        ..set('name', nameController.text.trim())
        ..set('phoneNo', phoneNoController.text.trim())
        ..set('email', emailController.text.trim() ?? '---')
        ..set('city', cityController.text.trim() ?? '---')
        ..set('address', addressController.text.trim() ?? '---');
      ParseResponse response = await customerType.save();
      if (response.success && response.results != null) {
        setCustomerLoading(false);
      } else {
        setCustomerLoading(false);
      }
    } on SocketException catch (e) {
      setCustomerLoading(false);
      print(e.message);
    }
  }

  void clearEditingControllers() {
    nameController.clear();
    phoneNoController.clear();
    emailController.clear();
    cityController.clear();
    addressController.clear();
  }
}
