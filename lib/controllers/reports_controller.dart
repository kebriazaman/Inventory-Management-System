import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportsController extends GetxController {
  final RxInt initialTab = 0.obs;

  final RxString _fromDate = ''.obs;
  final RxString _toDate = ''.obs;

  RxString get fromDate => _fromDate;
  RxString get toDate => _toDate;

  setFromDate(String value) => _fromDate.value = value;
  setToDate(String value) => _toDate.value = value;

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  Future<String?> datePicker(BuildContext context) async {
    String? formattedDate;
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      formattedDate = DateFormat('yyyy-MM-dd').format(date);
    }
    return formattedDate;
  }

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
}
