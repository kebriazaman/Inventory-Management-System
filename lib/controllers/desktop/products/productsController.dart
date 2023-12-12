import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/utils.dart';

class ProductsController extends GetxController {
  final RxList<CategoryModel> _categoryList = <CategoryModel>[].obs;
  RxList<ProductsModel> productsList = <ProductsModel>[].obs;

  final RxBool _isLoading = false.obs;
  final RxBool _isCategoryLoading = false.obs;
  final RxBool _isProductLoading = false.obs;

  final RxBool _isTyping = false.obs;

  RxBool get isLoading => _isLoading;
  RxBool get isCategoryLoading => _isCategoryLoading;
  RxBool get isProductLoading => _isProductLoading;

  RxBool get isTyping => _isTyping;

  RxList<CategoryModel> get categoryList => _categoryList;

  final _entryFormKey = GlobalKey<FormState>();
  final _categoryFormKey = GlobalKey<FormState>();

  final catInitValue = 'Select'.obs;

  late String _category;

  GlobalKey<FormState> get entryFormKey => _entryFormKey;
  GlobalKey<FormState> get categoryFormKey => _categoryFormKey;

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

  Future<void> addProduct(BuildContext context) async {
    String? categoryObjectId;
    isProductLoading.value = true;
    try {
      QueryBuilder<ParseObject> queryCategory = QueryBuilder(ParseObject('Category'))
        ..whereEqualTo('categoryName', _category);
      final apiResponse1 = await queryCategory.query();
      if (apiResponse1.success && apiResponse1.results != null) {
        final api1 = apiResponse1.results!.first;
        categoryObjectId = api1.get('objectId');
      }
      int discount = int.parse(discountController.text.trim().replaceAll(RegExp(r'[^0-9]'), '')); // 15%
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
        getProducts();
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
    } catch (e) {
      isProductLoading.value = false;
    }
  }

  Future<List<ProductsModel>> getProducts() async {
    productsList.clear();
    isLoading.value = true;
    try {
      QueryBuilder<ParseObject> queryProducts = QueryBuilder(ParseObject('Products'))..includeObject(['category']);
      final apiResponse = await queryProducts.query();
      if (apiResponse.success == true && apiResponse.results != null) {
        final decodeData = jsonDecode(apiResponse.results.toString());
        for (Map<String, dynamic> obj in decodeData) {
          productsList.add(ProductsModel.fromJson(obj));
        }
        isLoading.value = false;
        return productsList;
      }
    } catch (e) {
      isLoading.value = false;
    }
    return productsList;
  }

  Future<void> addCategory(BuildContext context) async {
    isCategoryLoading.value = true;
    try {
      ParseObject categoryObj = ParseObject('Category')..set('categoryName', categoryController.text.trim());

      final apiResponse = await categoryObj.save();
      if (apiResponse.success && apiResponse.results != null) {
        isCategoryLoading.value = false;
        getCategoryList();
      } else {
        isCategoryLoading.value = false;
        Utils.showDialogueBox(context, 'Error', apiResponse.error!.message, const Icon(Icons.cloud_off_rounded));
      }
      Get.back();
    } catch (e) {
      isCategoryLoading.value = false;
    }
  }

  Future<void> getCategoryList() async {
    categoryList.clear();
    isCategoryLoading.value = true;
    categoryList.add(CategoryModel(id: '0', name: 'Select'));
    QueryBuilder<ParseObject> parseQuery = QueryBuilder(ParseObject('Category'))..keysToReturn(['categoryName']);
    final apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      final apiRes = apiResponse.results!;
      for (ParseObject obj in apiRes) {
        categoryList.add(CategoryModel(id: obj.get('objectId'), name: obj.get('categoryName')));
      }
      isCategoryLoading.value = false;
    } else {
      isCategoryLoading.value = false;
    }
  }

  Future<void> deleteProduct(String objectId) async {
    var product = ParseObject('Products')..objectId = objectId;
    await product.delete();
  }

  Future<void> updateProductName(String objectId, String value) async {
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))
      ..includeObject(['category'])
      ..whereEqualTo('objectId', objectId);
    try {
      final apiResponse = await queryBuilder.query();
      if (apiResponse.success && apiResponse.results != null) {
        ParseObject product = apiResponse.results!.first;
        product.set('name', value);
        ParseResponse parseResponse = await product.save();
        if (parseResponse.success) {
          print('product updated');
        } else {
          print('product not updated');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> runLiveQuery() async {
    final LiveQuery liveQuery = LiveQuery();
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder<ParseObject>(ParseObject('Products'));
    Subscription subscription = await liveQuery.client.subscribe(queryBuilder);

    subscription.on(LiveQueryEvent.update, (value) async {
      var updatedProduct = value as ParseObject;
      var objectId = updatedProduct.get('objectId');
      try {
        QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))
          ..whereEqualTo('objectId', objectId)
          ..includeObject(['category']);
        final apiResponse = await queryBuilder.query();
        if (apiResponse.success && apiResponse.results != null) {
          ParseObject parseObject = apiResponse.results!.first;
          int index = productsList.indexWhere((element) => element.objectId == parseObject.objectId);
          var decodedData = jsonDecode(parseObject.toString());
          productsList[index] = ProductsModel.fromJson(decodedData);
        }
      } catch (e) {
        print(e);
      }
    });

    subscription.on(LiveQueryEvent.delete, (value) {
      productsList.removeWhere((element) => element.objectId == (value as ParseObject).objectId);
    });
  }
}
