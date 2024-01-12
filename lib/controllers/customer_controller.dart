import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/customers_model.dart';

class CustomerController extends GetxController {
  final RxBool _isCustomerLoading = false.obs;
  final RxBool isLoading = false.obs;
  final RxString _customer = ''.obs;
  final RxList selectedRowsIndex = [].obs;

  RxList<CustomersModel> customers = <CustomersModel>[].obs;
  final GlobalKey<FormBuilderState> customerFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> customerFormKey2 = GlobalKey<FormBuilderState>();

  RxBool get isCustomerLoading => _isCustomerLoading;
  RxString get customer => _customer;

  setCustomerLoading(bool value) => _isCustomerLoading.value = value;
  setCustomerValue(String value) => _customer.value = value;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController(text: '---');
  TextEditingController cityController = TextEditingController(text: '---');
  TextEditingController addressController = TextEditingController(text: '---');
  TextEditingController customerEditingController = TextEditingController(text: '---');

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

  Future<List<CustomersModel>> getCustomersList() async {
    isLoading.value = true;
    QueryBuilder<ParseObject> customerQuery = QueryBuilder(ParseObject('Customers'))..orderByDescending('createdAt');
    ParseResponse queryResponse = await customerQuery.query();
    if (queryResponse.success && queryResponse.results != null) {
      dynamic decodedData = jsonDecode(queryResponse.results.toString());
      customers.value = (decodedData as List).map((e) => CustomersModel.fromJson(e)).toList();
      isLoading.value = false;
      return customers;
    } else {
      isLoading.value = false;
      return [];
    }
  }

  Future<void> saveCustomer() async {
    setCustomerLoading(true);
    try {
      ParseObject customerType = ParseObject('Customers')
        ..set('name', nameController.text.trim())
        ..set('phoneNo', phoneNoController.text.trim())
        ..set('email', emailController.text)
        ..set('city', cityController.text.trim())
        ..set('address', addressController.text.trim());
      ParseResponse response = await customerType.save();
      if (response.success && response.results != null) {
        await getCustomersList();
        setCustomerLoading(false);
      } else {
        setCustomerLoading(false);
      }
    } on SocketException catch (e) {
      setCustomerLoading(false);
      print(e.message);
    }
  }

  Future<void> deleteCustomer(String id) async {
    ParseObject customer = ParseObject('Customers')..objectId = id;
    ParseResponse response = await customer.delete();
    if (response.success && response.results != null) {
      customers.removeWhere((element) => element.objectId == id);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getCustomersList();
  }

  void clearEditingControllers() {
    nameController.clear();
    phoneNoController.clear();
    emailController.clear();
    cityController.clear();
    addressController.clear();
  }

  List<DataColumn2> dataTableColumns = [
    const DataColumn2(label: Text('Id')),
    const DataColumn2(label: Text('Name')),
    const DataColumn2(label: Text('Phone number')),
    const DataColumn2(label: Text('Email')),
    const DataColumn2(label: Text('City')),
    const DataColumn2(label: Text('Address')),
    const DataColumn2(label: Text('Action')),
  ];
}
