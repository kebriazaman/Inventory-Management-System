import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/reports/sales_items_model.dart';

import '../models/reports/sales_model.dart';

class ReportsController extends GetxController {
  final RxInt initialTab = 0.obs;

  final RxList<SalesModel> salesList = <SalesModel>[].obs;
  final RxList<SalesItemsModel> salesItemsList = <SalesItemsModel>[].obs;

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  final FocusNode fromDateFocusNode = FocusNode();
  final FocusNode toDateFocusNode = FocusNode();
  final FocusNode generateBtnFocusNode = FocusNode();

  Future<void> generatingMonthWiseReport() async {
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Sales'))
      ..includeObject(['customer'])
      ..whereGreaterThanOrEqualsTo('customCreatedAt', fromDateController.text)
      ..whereLessThanOrEqualTo('customCreatedAt', toDateController.text);
    ParseResponse response = await queryBuilder.query();

    if (response.success && response.results != null) {
      dynamic decodedJson = jsonDecode(response.results.toString());
      salesList.value = (decodedJson as List).map((e) => SalesModel.fromJson(e)).toList();
      ParseRelation relObj = response.results!.first['salesItems'];
      var o = relObj.getQuery()..includeObject(['product']);
      ParseResponse res = await o.query();
      if (res.success && res.results != null) {
        dynamic decodedRel = jsonDecode(res.results.toString());
        salesItemsList.value = (decodedRel as List).map((e) => SalesItemsModel.fromJson(e)).toList();
      }
      print(salesList.first.grandTotal);
    } else {
      print(response.error!.message);
    }
  }

  Future<String?> datePicker(BuildContext context) async {
    String? formattedDate;
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      formattedDate = DateFormat('yyyy MM dd').format(date);
    }
    return formattedDate;
  }

  final List<DataColumn> tableColumns = [
    const DataColumn(label: Text('id')),
    const DataColumn(label: Text('Date')),
    const DataColumn(label: Text('Customer')),
    const DataColumn(label: Text('Payment')),
    const DataColumn(label: Text('Subtotal')),
    const DataColumn(label: Text('Discount')),
    const DataColumn(label: Text('Collected Amount')),
    const DataColumn(label: Text('Change Amount')),
    const DataColumn(label: Text('Total')),
  ];

  final List<Tab> tabsList = [
    const Tab(text: 'January'),
    const Tab(text: 'February'),
    const Tab(text: 'March'),
    const Tab(text: 'April'),
    const Tab(text: 'May'),
    const Tab(text: 'June'),
    const Tab(text: 'July'),
    const Tab(text: 'August'),
    const Tab(text: 'September'),
    const Tab(text: 'October'),
    const Tab(text: 'November'),
    const Tab(text: 'December'),
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
