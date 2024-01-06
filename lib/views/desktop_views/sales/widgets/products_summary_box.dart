import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';

class ProductsSummaryBox extends StatelessWidget {
  const ProductsSummaryBox({super.key});
  @override
  Widget build(BuildContext context) {
    final SalesController salesController = Get.find<SalesController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              'Summary',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            salesController.selectedProducts.length.toString(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'Rs. ${salesController.subTotal.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax, 5%',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'Rs. ${salesController.tax.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service, POS Tax',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'Rs. ${salesController.service.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount, 1%',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'Rs. ${salesController.discount.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Rs. ${salesController.total.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          )
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
