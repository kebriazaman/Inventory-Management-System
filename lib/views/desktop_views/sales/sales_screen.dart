import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/debouncer.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/appbar_search_field.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/auto_complete_field.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/custom_category_tabs.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/products_data_table.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/products_summary_box.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/salected_items_list.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/sales_action_buttons.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/sales_shimmer_effect_loading.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);
  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late final Debouncer _debouncer;
  late final SalesController salesController;
  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(millisecs: 600);
    salesController = Get.put(SalesController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SalesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return salesController.isLoading.value
            ? const SalesShimmerEffectLoading()
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: AppBar(
                    surfaceTintColor: AppColors.transparentColor,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('POS',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                    ),
                    // leading: Image.asset(ImageAssets.posLogo, fit: BoxFit.fill),
                    title: Row(
                      children: [
                        AppbarSearchField(debouncer: _debouncer),
                        10.width,
                        const AutoCompleteField(),
                      ],
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomCategoryTabs(salesController: salesController),
                            10.height,
                            const ProductsDataTable(),
                          ],
                        ),
                      ),
                      10.width,
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                    border: Border.all(color: AppColors.primaryColor.withOpacity(0.1)),
                                  ),
                                  child: Obx(
                                    () => salesController.selectedProducts.isEmpty
                                        ? const Center(child: Text('No items selected'))
                                        : const SelectedItemsList(),
                                  ),
                                ),
                              ),
                              5.height,
                              const ProductsSummaryBox(),
                              const SalesActionButtons(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
