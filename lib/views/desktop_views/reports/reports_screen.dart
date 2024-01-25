import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/reports_controller.dart';
import 'package:pos_fyp/views/desktop_views/reports/widgets/report_screen_header.dart';

import '../../../res/app_color.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReportScreenHeader(),
            SizedBox(height: Get.height * 0.05),
            DefaultTabController(
              initialIndex: reportsController.initialTab.value,
              length: reportsController.tabsList.length,
              child: TabBar(
                tabs: reportsController.tabsList,
                dividerColor: AppColors.transparentColor,
                isScrollable: true,
                labelPadding: const EdgeInsets.only(right: 32.0, left: 8.0),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: DataTable2(
                dataRowColor: MaterialStateProperty.all(AppColors.whiteColor),
                dataTextStyle: Theme.of(context).textTheme.bodySmall,
                headingRowDecoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1)),
                headingRowHeight: Get.height * 0.05,
                columnSpacing: 20,
                horizontalMargin: 20.0,
                checkboxHorizontalMargin: 10.0,
                columns: reportsController.tableColumns,
                rows: reportsController.salesList.map((element) {
                  return DataRow2(cells: [
                    DataCell(Text(element.objectId ?? '---')),
                    DataCell(Text(element.customCreatedAt ?? '---')),
                    DataCell(Text(element.customer?.name ?? '---')),
                    DataCell(Text(element.paymentType ?? '---')),
                    DataCell(Text('Rs. ${element.subtotal}' ?? '---')),
                    DataCell(Text('Rs. ${element.discount}' ?? '---')),
                    DataCell(Text('Rs. ${element.collectedAmount}' ?? '---')),
                    DataCell(Text('Rs. ${element.changeAmount}' ?? '---')),
                    DataCell(Text('Rs. ${element.grandTotal}' ?? '---')),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
