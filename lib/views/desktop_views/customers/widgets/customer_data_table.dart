import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';

class CustomerDataTable extends StatelessWidget {
  const CustomerDataTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DataTable2(
        datarowCheckboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(AppColors.blackColor),
          fillColor: MaterialStateProperty.all(AppColors.whiteColor),
          shape: const CircleBorder(),
          side: const BorderSide(color: AppColors.appButtonColor),
        ),
        headingCheckboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(AppColors.blackColor),
          fillColor: MaterialStateProperty.all(AppColors.whiteColor),
          shape: const CircleBorder(),
          side: const BorderSide(color: AppColors.appButtonColor),
        ),
        dataRowColor: MaterialStateProperty.all(AppColors.whiteColor),
        dataTextStyle: Theme.of(context).textTheme.bodySmall,
        headingRowDecoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1)),
        headingRowHeight: Get.height * 0.05,
        columnSpacing: 20,
        columns: const [
          DataColumn2(label: Text('No')),
          DataColumn2(label: Text('Id')),
          DataColumn2(label: Text('Name')),
          DataColumn2(label: Text('Type')),
          DataColumn2(label: Text('Phone No')),
          DataColumn2(label: Text('Email')),
          DataColumn2(label: Text('City')),
          DataColumn2(label: Text('Address')),
        ],
        horizontalMargin: 20.0,
        checkboxHorizontalMargin: 10.0,
        rows: const [
          DataRow2(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('123sldkjf')),
              DataCell(Text('kebria')),
              DataCell(Text('Walkin')),
              DataCell(Text('0123456789')),
              DataCell(Text('kebria.zaman@gmail.com')),
              DataCell(Text('Thal')),
              DataCell(Text('thal city')),
            ],
          ),
        ],
      ),
    );
  }
}
