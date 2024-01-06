import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';

class CustomCategoryTabs extends StatelessWidget {
  final SalesController salesController;
  const CustomCategoryTabs({required this.salesController, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(left: 8.0), child: Text('Categories')),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: salesController.categories.length,
              controller: ScrollController(),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    hoverColor: AppColors.transparentColor,
                    highlightColor: AppColors.transparentColor,
                    splashColor: AppColors.transparentColor,
                    onTap: () {
                      salesController.setSelectedIndex(index);
                      salesController.fetchProductsByCategory(salesController.categories[index].id.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        decoration: BoxDecoration(
                          color: salesController.selectedIndex.value == index
                              ? const Color(0xffE8FDFD)
                              : AppColors.whiteColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: AppColors.primaryColor.withOpacity(0.1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            salesController.categories[index].name.toString(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
