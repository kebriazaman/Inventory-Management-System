import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:pos_fyp/utils/utils.dart';

class ProductsController extends GetxController {
  final RxList<CategoryModel> _categoryList = <CategoryModel>[].obs;
  final RxList<ProductsModel> productsList = <ProductsModel>[].obs;
  final RxList<ProductsModel> filteredProducts = <ProductsModel>[].obs;

  final RxInt availableItems = 0.obs;
  final RxInt unAvailableItems = 0.obs;

  final RxBool _isLoading = false.obs;
  final RxBool _isCategoryLoading = false.obs;
  final RxBool _isProductLoading = false.obs;

  final RxString _categorySelectedValue = 'Select'.obs;

  RxBool get isLoading => _isLoading;
  RxBool get isCategoryLoading => _isCategoryLoading;
  RxBool get isProductLoading => _isProductLoading;
  RxString get categorySelectedValue => _categorySelectedValue;
  RxList<CategoryModel> get categoryList => _categoryList;

  final _entryFormKey = GlobalKey<FormState>();
  final _categoryFormKey = GlobalKey<FormState>();

  late String _category;

  GlobalKey<FormState> get entryFormKey => _entryFormKey;
  GlobalKey<FormState> get categoryFormKey => _categoryFormKey;

  void setFormCategory(String value) => _category = value;
  void setCategory(String value) => _categorySelectedValue.value = value;
  void setLoading(bool v) => _isLoading.value = v;
  void setCategoryLoading(bool v) => _isCategoryLoading.value = v;

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
  FocusNode dropdownBtnFocusNode = FocusNode();

  Future<void> addProduct(BuildContext context) async {
    String? categoryObjectId;
    setLoading(true);
    try {
      QueryBuilder<ParseObject> queryCategory = QueryBuilder(ParseObject('Category'))
        ..whereEqualTo('categoryName', _category);
      final apiResponse1 = await queryCategory.query();
      if (apiResponse1.success && apiResponse1.results != null) {
        final api1 = apiResponse1.results!.first;
        categoryObjectId = api1.get('objectId');
      }

      int discount = int.parse(discountController.text.trim()); // 15%
      double discountRate = discount / 100;
      double salePrice = double.parse(salePriceController.text.trim());
      double discountValue = salePrice * discountRate;
      double netValue = salePrice - discountValue;

      var product = ParseObject('Products')
        ..set('name', nameController.text)
        ..set('category', (ParseObject('Category')..objectId = categoryObjectId).toPointer())
        ..set('quantity', qtyController.text)
        ..set('discountPercentage', discountController.text.trim())
        ..set('discountValue', discountValue.toStringAsFixed(2))
        ..set('salePrice', double.parse(salePriceController.text.trim()).toStringAsFixed(2))
        ..set('purchasePrice', double.parse(purchasePriceController.text.trim()).toStringAsFixed(2))
        ..set('netValue', netValue.toStringAsFixed(2))
        ..set('manufacturer', manufacturerController.text.trim());

      qtyController.text.trim() == '0' ? product.set('status', 'out-of-stock') : product.set('status', 'available');

      final apiResponse = await product.save();
      if (apiResponse.success && apiResponse.results != null) {
        setLoading(false);
      } else {
        setLoading(false);
        Utils.showDialogueMessage('Error', apiResponse.error!.message, Icons.error_outline);
      }
    } catch (e) {
      setLoading(false);
      Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
    }
  }

  Future<List<ProductsModel>> fetchProducts() async {
    productsList.clear();
    setLoading(true);
    try {
      QueryBuilder<ParseObject> queryProducts = QueryBuilder(ParseObject('Products'))..includeObject(['category']);
      final apiResponse = await queryProducts.query();
      if (apiResponse.success == true && apiResponse.results != null) {
        final decodeData = jsonDecode(apiResponse.results.toString());
        for (Map<String, dynamic> obj in decodeData) {
          productsList.add(ProductsModel.fromJson(obj));
        }
        filteredProducts.assignAll(productsList);
        watchItemsStatus();
        setLoading(false);
        return productsList;
      } else {
        Utils.showDialogueMessage('Error', apiResponse.error!.message, Icons.error_outline);
      }
    } catch (e) {
      setLoading(false);
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
        fetchCategories();
      } else {
        isCategoryLoading.value = false;
        Utils.showDialogueBox(context, 'Error', apiResponse.error!.message, const Icon(Icons.cloud_off_rounded));
      }
      Get.back();
    } catch (e) {
      isCategoryLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    setCategoryLoading(true);
    categoryList.clear();
    try {
      categoryList.add(CategoryModel(id: '0', name: 'Select'));
      QueryBuilder<ParseObject> parseQuery = QueryBuilder(ParseObject('Category'));
      final apiResponse = await parseQuery.query();
      if (apiResponse.success && apiResponse.results != null) {
        final apiRes = apiResponse.results!;
        for (ParseObject obj in apiRes) {
          categoryList.add(CategoryModel.fromJson(obj.toJson()));
        }
        setCategoryLoading(false);
      } else {
        setCategoryLoading(false);
        Utils.showDialogueMessage('Error', apiResponse.error!.message, Icons.error_outline);
      }
    } catch (e) {
      Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
    }
  }

  Future<void> deleteProduct(String objectId) async {
    var product = ParseObject('Products')..objectId = objectId;
    await product.delete();
  }

  Future<void> updateProductName(String objectId, String value) async {
    setLoading(true);
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
          setLoading(false);
        } else {
          setLoading(false);
          Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
        }
      }
    } catch (e) {
      Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
    }
  }

  Future<void> updateProductDiscount(String objectId, String value) async {
    setLoading(true);
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))..whereEqualTo('objectId', objectId);
    try {
      final apiResponse = await queryBuilder.query();
      if (apiResponse.success && apiResponse.results != null) {
        ParseObject product = apiResponse.results!.first;
        double discountRate = double.parse(value) / 100;
        double salePrice = double.parse(product.get('salePrice'));
        double discountValue = salePrice * discountRate;
        double netValue = salePrice - discountValue;

        product.set('discountPercentage', value);
        product.set('discountValue', discountValue.toStringAsFixed(2));
        product.set('netValue', netValue.toStringAsFixed(2));
        value == '0' ? product.set('status', 'out-of-stock') : product.set('status', 'available');
        ParseResponse parseResponse = await product.save();
        if (parseResponse.success) {
          setLoading(false);
        } else {
          setLoading(false);
          Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
        }
      }
    } catch (e) {
      setLoading(false);
      Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
    }
  }

  Future<void> updateSalePrice(String objectId, String sp) async {
    setLoading(true);
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))..whereEqualTo('objectId', objectId);
    try {
      final apiResponse = await queryBuilder.query();
      if (apiResponse.success && apiResponse.results != null) {
        ParseObject product = apiResponse.results!.first;

        String discount = product.get('discountPercentage');
        double discountRate = double.parse(discount) / 100;
        double salePrice = double.parse(sp);
        double discountValue = salePrice * discountRate;
        double netValue = salePrice - discountValue;

        product.set('discountPercentage', discount);
        product.set('discountValue', discountValue.toStringAsFixed(2));
        product.set('salePrice', salePrice.toStringAsFixed(2));
        product.set('netValue', netValue.toStringAsFixed(2));
        ParseResponse parseResponse = await product.save();
        if (parseResponse.success) {
          setLoading(false);
        } else {
          setLoading(false);
          Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
        }
      }
    } catch (e) {
      setLoading(false);
      Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
    }
  }

  Future<void> updateProductQuantity(String objectId, String qty) async {
    setLoading(true);
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))..whereEqualTo('objectId', objectId);
    try {
      final apiResponse = await queryBuilder.query();
      if (apiResponse.success && apiResponse.results != null) {
        ParseObject product = apiResponse.results!.first;
        product.set('quantity', qty);
        product.get('quantity') == '0' ? product.set('status', 'out-of-stock') : product.set('status', 'available');

        ParseResponse parseResponse = await product.save();

        if (parseResponse.success) {
          setLoading(false);
        } else {
          setLoading(false);
          Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
        }
      }
    } catch (e) {
      setLoading(false);
      Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
    }
  }

  Future<void> runLiveQuery() async {
    final LiveQuery liveQuery = LiveQuery();
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder<ParseObject>(ParseObject('Products'));
    Subscription subscription = await liveQuery.client.subscribe(queryBuilder);
    // ********* defined live queries from here
    subscription.on(LiveQueryEvent.create, (value) async {
      final String objectId = value['objectId'];
      try {
        QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))
          ..whereEqualTo('objectId', objectId)
          ..includeObject(['category']);
        final response = await queryBuilder.query();
        if (response.success && response.results != null) {
          final ParseObject parseObject = response.results!.first;
          filteredProducts.add(ProductsModel.fromJson(jsonDecode(parseObject.toString())));
          watchItemsStatus();
        }
      } catch (e) {
        Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
      }
    });

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
          int index = filteredProducts.indexWhere((element) => element.objectId == parseObject.objectId);
          var decodedData = jsonDecode(parseObject.toString());
          filteredProducts[index] = ProductsModel.fromJson(decodedData);
          watchItemsStatus();
        }
      } catch (e) {
        Utils.showDialogueMessage('Error', e.toString(), Icons.error_outline);
      }
    });

    subscription.on(LiveQueryEvent.delete, (value) {
      filteredProducts.removeWhere((element) => element.objectId == (value as ParseObject).objectId);
    });
  }

  void filterProductsByName(String name) {
    if (name != '') {
      filteredProducts.value =
          productsList.where((element) => element.name.toLowerCase().contains(name.toLowerCase())).toList();
    } else {
      filteredProducts.assignAll(productsList);
    }
  }

  void filterProductsByCategory(String value) {
    if (value != 'Select') {
      filteredProducts.value = productsList
          .where((element) => element.category.categoryName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      filteredProducts.assignAll(productsList);
    }
  }

  void watchItemsStatus() {
    availableItems.value = filteredProducts.where((element) => element.status.toLowerCase() == 'available').length;
    unAvailableItems.value = filteredProducts.where((element) => element.status.toLowerCase() == 'out-of-stock').length;
  }

  @override
  void onInit() async {
    super.onInit();
    fetchCategories();
    fetchProducts();
    await runLiveQuery();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    categoryController.dispose();
    qtyController.dispose();
    salePriceController.dispose();
    purchasePriceController.dispose();
    discountController.dispose();
    manufacturerController.dispose();
  }
}
