import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/extensions.dart';

class SelectedItemsList extends StatelessWidget {
  const SelectedItemsList({super.key});
  @override
  Widget build(BuildContext context) {
    final SalesController salesController = Get.find<SalesController>();
    return Obx(
      () => ListView.builder(
        itemCount: salesController.selectedProducts.length,
        itemBuilder: (context, index) {
          var product = salesController.selectedProducts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          product.name ?? '...',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Text(
                        product.price ?? '0.0',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: AppColors.primaryColor.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          salesController.recalculateProductSummary(product);
                        },
                        hoverColor: AppColors.transparentColor,
                        icon: const Icon(Icons.remove, size: 10),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(10, 10),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                      5.width,
                      Obx(() => Text(product.qty!.value.toString())),
                      5.width,
                      IconButton(
                        onPressed: () {
                          salesController.calculateProductSummary(product);
                        },
                        icon: const Icon(Icons.add, size: 10.0),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(10, 10),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
