import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/utils/debouncer.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/utils/wave_painter.dart';
import 'package:pos_fyp/views/desktop_views/customers/widgets/customer_data_table.dart';
import 'package:pos_fyp/views/desktop_views/customers/widgets/customer_entry_button.dart';
import 'package:pos_fyp/views/desktop_views/customers/widgets/customer_search_field.dart';

class CustomersScreen extends StatefulWidget {
  CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final Debouncer _debouncer = Debouncer(millisecs: 800);

  late final CustomerController customerController;

  @override
  void initState() {
    super.initState();
    customerController = Get.put(CustomerController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CustomerController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: WavePainter(Utils.generatePoints(context)),
              child: Container(),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Customers',
                          style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const CustomerSearchField(),
                          10.width,
                          const CustomerEntryButton(),
                          10.width,
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.06),
                const Expanded(child: CustomerDataTable()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
