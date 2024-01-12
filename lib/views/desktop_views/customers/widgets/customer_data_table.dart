import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/forms/add_customer_form.dart';

class CustomerDataTable extends StatelessWidget {
  const CustomerDataTable({super.key});
  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.put(CustomerController());
    return Obx(
      () => customerController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(TextSpan(
                      text: 'Total Customers: ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: customerController.customers.length.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ])),
                ),
                Expanded(
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
                    horizontalMargin: 20.0,
                    checkboxHorizontalMargin: 10.0,
                    columns: customerController.dataTableColumns,
                    rows: customerController.filteredCustomers
                        .map((element) => DataRow2(cells: [
                              DataCell(Text(element.objectId.toString())),
                              DataCell(Text(element.name.toString())),
                              DataCell(Text(element.phoneNo.toString())),
                              DataCell(Text(element.email.toString())),
                              DataCell(Text(element.city.toString())),
                              DataCell(Text(element.address.toString())),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      onPressed: () => customerController.deleteCustomer(element.objectId.toString()),
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () async{
                                        customerController.flag.value = 0;
                                        await customerController.fetchCustomersById(element.objectId.toString());
                                        Get.defaultDialog(
                                          barrierDismissible: false,
                                          title: 'Edit',
                                            content: customerController.isLoading.value ? const SizedBox.shrink() : AddCustomerForm(customerController: customerController, id: element.objectId.toString()));
                                      },
                                      icon: const Icon(Icons.edit))
                                ],
                              )),
                            ]))
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
