import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/discount_model.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/utils.dart';

class ProductsController extends GetxController {
  final RxList<CategoryModel> _categoryList = <CategoryModel>[].obs;
  final RxList<DiscountModel> _discountList = <DiscountModel>[].obs;

  RxList<ProductsModel> productsList = <ProductsModel>[].obs;

  final RxBool _isCategoryLoading = false.obs;
  final RxBool _isProductLoading = false.obs;

  RxBool get isCategoryLoading => _isCategoryLoading;
  RxBool get isProductLoading => _isProductLoading;

  RxList<CategoryModel> get categoryList => _categoryList;

  final _entryFormKey = GlobalKey<FormState>();
  final _categoryFormKey = GlobalKey<FormState>();

  final catInitValue = 'Select'.obs;

  late String _discount;
  late String _category;

  GlobalKey<FormState> get entryFormKey => _entryFormKey;
  GlobalKey<FormState> get categoryFormKey => _categoryFormKey;

  set setDiscount(String value) {
    _discount = value;
  }

  set setCategory(String value) {
    _category = value;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();

  FocusNode codeFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode categoryFocusNode = FocusNode();
  FocusNode qtyFocusNode = FocusNode();
  FocusNode purchasePriceFocusNode = FocusNode();
  FocusNode salePriceFocusNode = FocusNode();
  FocusNode discountFocusNode = FocusNode();
  FocusNode gstFocusNode = FocusNode();
  FocusNode manufacturerFocusNode = FocusNode();
  FocusNode addButtonFocusNode = FocusNode();

  FocusNode addCatBtnFocusNode = FocusNode();

  void addProduct(BuildContext context) async {
    String? categoryObjectId;
    isProductLoading.value = true;

    QueryBuilder<ParseObject> queryCategory = QueryBuilder(ParseObject('Category'))
      ..whereEqualTo('categoryName', _category);
    final apiResponse1 = await queryCategory.query();
    if (apiResponse1.success && apiResponse1.results != null) {
      final api1 = apiResponse1.results!.first;
      categoryObjectId = api1.get('objectId');
    }

    int discount = int.parse(discountController.text.trim().replaceAll(new RegExp(r'[^0-9]'), '')); // 15%
    double discountRate = discount / 100;
    double purchasePrice = double.parse(purchasePriceController.text.trim());
    double discountValue = purchasePrice * discountRate;
    double netValue = purchasePrice - discountValue;

    var product = ParseObject('Products')
      ..set('name', nameController.text)
      ..set('category', (ParseObject('Category')..objectId = categoryObjectId).toPointer())
      ..set('quantity', qtyController.text)
      ..set('discount', discountController.text.trim())
      ..set('salePrice', double.parse(salePriceController.text.trim()))
      ..set('purchasePrice', double.parse(purchasePriceController.text.trim()))
      ..set('netValue', netValue.toString())
      ..set('manufacturer', manufacturerController.text.trim());

    final apiResponse = await product.save();

    if (apiResponse.success && apiResponse.results != null) {
      isProductLoading.value = false;
      Utils.fieldFocusChange(context, addButtonFocusNode, nameFocusNode);
    } else {
      isProductLoading.value = false;
      Utils.showDialogueBox(
        context,
        'Error',
        apiResponse.error!.message,
        Icon(Icons.error_outline, color: AppColors.redColor, size: 60.0),
      );
    }
  }

  Future<List<ProductsModel>> getProducts() async {
    QueryBuilder<ParseObject> queryProducts = QueryBuilder(ParseObject('Products'))..includeObject(['category']);
    final apiResonse = await queryProducts.query();
    if (apiResonse.success == true && apiResonse.results != null) {
      final decodeData = jsonDecode(apiResonse.results.toString());
      for (Map i in decodeData) {
        productsList.add(ProductsModel.fromJson(i.cast()));
      }
      return productsList;
    }
    return productsList;
  }

  void addCategory(BuildContext context) {
    isCategoryLoading.value = true;
    ParseObject categoryObj = ParseObject('Category')..set('categoryName', categoryController.text.trim());
    categoryObj.save().then((value) {
      isCategoryLoading.value = false;
    }).onError((error, stackTrace) {
      isCategoryLoading.value = false;
      Utils.showDialogueBox(context, 'Error', error.toString(), Icon(Icons.cloud_off_rounded));
    });
    Get.back();
  }

  Future<void> getCategoryList() async {
    categoryList.clear();
    isCategoryLoading.value = true;
    categoryList.add(CategoryModel('0', 'Select'));
    QueryBuilder<ParseObject> parseQuery = QueryBuilder(ParseObject('Category'))..keysToReturn(['categoryName']);
    final apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      final apiRes = apiResponse.results!;
      for (ParseObject obj in apiRes) {
        categoryList.add(CategoryModel(obj.get('objectId'), obj.get('categoryName')));
      }
      isCategoryLoading.value = false;
    } else {
      isCategoryLoading.value = false;
    }
  }
}
