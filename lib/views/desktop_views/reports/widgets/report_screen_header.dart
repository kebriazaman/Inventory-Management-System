import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/reports_controller.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/reports/widgets/date_form_field.dart';
import 'package:pos_fyp/views/desktop_views/reports/widgets/generate_report_button.dart';

class ReportScreenHeader extends StatelessWidget {
  const ReportScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.find<ReportsController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Reports', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
          Row(
            children: [
              DateFormField(
                hintText: 'From Date',
                onPress: () async {
                  String? fromDate = (await reportsController.datePicker(context));
                  reportsController.fromDateController.text = fromDate ?? '';
                  Utils.fieldFocusChange(
                      context, reportsController.fromDateFocusNode, reportsController.toDateFocusNode);
                },
                controller: reportsController.fromDateController,
                focusNode: reportsController.fromDateFocusNode,
              ),
              const SizedBox(width: 20.0),
              DateFormField(
                hintText: 'To Date',
                onPress: () async {
                  String? toDate = (await reportsController.datePicker(context));
                  reportsController.toDateController.text = toDate ?? '';
                  Utils.fieldFocusChange(
                      Get.context!, reportsController.toDateFocusNode, reportsController.generateBtnFocusNode);
                },
                controller: reportsController.toDateController,
                focusNode: reportsController.toDateFocusNode,
              ),
              const SizedBox(width: 20.0),
              GenerateReportButton(
                title: 'Generate',
                onPress: () {
                  reportsController.generatingMonthWiseReport();
                },
                focusNode: reportsController.generateBtnFocusNode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
