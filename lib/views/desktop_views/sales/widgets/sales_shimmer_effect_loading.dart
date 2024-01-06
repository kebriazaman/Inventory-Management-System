import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class SalesShimmerEffectLoading extends StatelessWidget {
  const SalesShimmerEffectLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: AppColors.greyColor,
                ),
                10.width,
                Container(
                  width: Get.width * 0.53,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                10.width,
                Container(
                  width: Get.width * 0.2,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Container(color: Colors.grey, width: 50, height: 20)),
                        SizedBox(
                          height: Get.height * 0.1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.height,
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(color: Colors.grey),
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Shimmer.fromColors(
              period: const Duration(milliseconds: 800),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  5.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      width: 100,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  5.height,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  5.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30.0,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
