import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/reports_controller.dart';

import '../../../utils/utils.dart';
import '../../../utils/wave_painter.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());
    return Scaffold(
        body: Stack(
      children: [
        CustomPaint(
          painter: WavePainter(Utils.generatePoints(context)),
          child: Container(),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Reports',
                      style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                  Row(children: [
                    SizedBox(
                      width: Get.width * 0.2,
                      child: TextFormField(
                        validator: (v) => !GetUtils.isDateTime(v!) ? 'Enter valid date format, yy-mm-dd' : null,
                        keyboardType: TextInputType.datetime,
                        controller: reportsController.fromDateController,
                        decoration: InputDecoration(
                          hintText: 'From Date',
                          suffixIcon: IconButton(
                              onPressed: () async {
                                String? fromDate = (await reportsController.datePicker(context));
                                reportsController.setFromDate(fromDate);
                                reportsController.fromDateController.text = reportsController.fromDate.value;
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.2,
                      child: TextFormField(
                        validator: (v) => !GetUtils.isDateTime(v!) ? 'Enter valid date format, yy-mm-dd' : null,
                        keyboardType: TextInputType.datetime,
                        controller: reportsController.toDateController,
                        decoration: InputDecoration(
                          hintText: 'To Date',
                          suffixIcon: IconButton(
                              onPressed: () async {
                                String toDate = (await reportsController.datePicker(context)).toString();
                                reportsController.setToDate(toDate);
                                reportsController.toDateController.text = reportsController.toDate.value;
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            DefaultTabController(
              initialIndex: reportsController.initialTab.value,
              length: reportsController.tabsList.length,
              child: TabBar(tabs: reportsController.tabsList),
            ),
          ],
        ),
      ],
    ));
  }
}
