import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/debouncer.dart';

class AppbarSearchField extends StatelessWidget {
  const AppbarSearchField({required this.debouncer, super.key});
  final Debouncer debouncer;

  @override
  Widget build(BuildContext context) {
    final SalesController salesController = Get.find<SalesController>();
    return Expanded(
      flex: 3,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: kAppbarTextFieldDecoration,
        onChanged: (value) {
          debouncer.run(() {
            salesController.filterProducts(value);
          });
        },
      ),
    );
  }
}
