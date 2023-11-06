import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/discount_model.dart';
import 'package:pos_fyp/utils/utils.dart';

class ProductsController extends GetxController {
  RxList<CategoryModel> _categoryList = <CategoryModel>[].obs;
  RxList<DiscountModel> _discountList = <DiscountModel>[].obs;

  final RxBool _isCategoryLoading = false.obs;
  final RxBool _isProductLoading = false.obs;
  final RxBool _isDiscountLoading = false.obs;

  RxBool get isCategoryLoading => _isCategoryLoading;
  RxBool get isProductLoading => _isProductLoading;
  RxBool get isDiscountLoading => _isDiscountLoading;

  RxList<CategoryModel> get categoryList => _categoryList;
  RxList<DiscountModel> get discountList => _discountList;

  final _entryFormKey = GlobalKey<FormState>();
  final _discountFormKey = GlobalKey<FormState>();
  final _categoryFormKey = GlobalKey<FormState>();

  final catInitValue = 'Select'.obs;
  final discInitValue = 'Select'.obs;

  late String _discount;
  late String _category;
  late double discountValue;

  GlobalKey<FormState> get entryFormKey => _entryFormKey;
  GlobalKey<FormState> get discountFormKey => _discountFormKey;
  GlobalKey<FormState> get categoryFormKey => _categoryFormKey;

  set setDiscount(String value) {
    _discount = value;
  }

  set setCategory(String value) {
    _category = value;
  }

  TextEditingController productCodeController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productPurchasePriceController = TextEditingController();
  TextEditingController productSalePriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productGSTPerController = TextEditingController();
  TextEditingController productManufacturerController = TextEditingController();

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

  FocusNode addDiscBtnFocusNode = FocusNode();
  FocusNode addCatBtnFocusNode = FocusNode();

  void addProduct(BuildContext context) async {
    String? categoryObjectId;
    String? discountObjectId;
    int? dValue;

    isProductLoading.value = true;

    QueryBuilder<ParseObject> queryCategory = QueryBuilder(ParseObject('Category'))
      ..whereEqualTo('categoryName', _category);
    final apiResponse1 = await queryCategory.query();
    if (apiResponse1.success && apiResponse1.results != null) {
      final api1 = apiResponse1.results!.first;
      categoryObjectId = api1.get('objectId');
    }

    QueryBuilder<ParseObject> discountQuery = QueryBuilder(ParseObject('Discount'))
      ..whereEqualTo('discountPercentage', _discount);
    final apiResponse2 = await discountQuery.query();
    if (apiResponse2.success && apiResponse2.results != null) {
      final api2 = apiResponse2.results!.first;
      discountObjectId = api2.get('objectId');
      dValue = api2.get('discountValue');
    }

    // Calculating gst %
    int gstPercentage = int.parse(productGSTPerController.text.trim());
    double gstValue = (gstPercentage / 100) * int.parse(productSalePriceController.text.trim());
    double netValue = (int.parse(productSalePriceController.text.trim()) - dValue! - gstValue);

    var product = ParseObject('Products')
      ..set('name', productNameController.text)
      ..set('category', (ParseObject('Category')..objectId = categoryObjectId).toPointer())
      ..set('quantity', productQuantityController.text)
      ..set('discount', (ParseObject('Discount')..objectId = discountObjectId).toPointer())
      ..set('purchasePrice', double.parse(productPurchasePriceController.text.trim()))
      ..set('salePrice', double.parse(productSalePriceController.text.trim()))
      ..set('gstPercentage', productGSTPerController.text.trim())
      ..set('gstValue', gstValue)
      ..set('netValue', netValue)
      ..set('manufacturer', productManufacturerController.text.trim());
    product.save().then((value) {
      isProductLoading.value = false;
      Utils.showDialogueBox(context, 'Item added', 'Item has been added', const Icon(Icons.info_outline_rounded));
      Utils.fieldFocusChange(context, addButtonFocusNode, nameFocusNode);
    }).onError((error, stackTrace) {
      Utils.showDialogueBox(context, 'Error', error.toString(), const Icon(Icons.cloud_off_rounded));
    });
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
    categoryList.add(CategoryModel('0', 'Select'));
    QueryBuilder<ParseObject> parseQuery = QueryBuilder(ParseObject('Category'))..keysToReturn(['categoryName']);
    final apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      final apiRes = apiResponse.results!;
      for (ParseObject obj in apiRes) {
        categoryList.add(CategoryModel(obj.get('objectId'), obj.get('categoryName')));
      }
    } else {
      print(apiResponse.error);
    }
  }

  Future<void> addDiscount() async {
    isDiscountLoading.value = true;
    // calculating discount
    var disc = productDiscountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    var discountAmount = int.parse(disc);
    discountValue = (discountAmount / 100) * int.parse(productSalePriceController.text.trim());
    ParseObject discountObj = ParseObject('Discount')
      ..set('discountValue', discountValue)
      ..set('discountPercentage', productDiscountController.text.trim());
    discountObj.save().then((value) {
      isDiscountLoading.value = false;
      Get.back();
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future<void> getDiscountList() async {
    discountList.clear();
    discountList.add(DiscountModel('0', 'Select', 'Select'));
    QueryBuilder<ParseObject> parseQuery = QueryBuilder(ParseObject('Discount'));
    final apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      final apiRes = apiResponse.results!;
      for (ParseObject obj in apiRes) {
        discountList.add(
            DiscountModel(obj.get('objectId'), obj.get('discountPercentage'), obj.get('discountValue').toString()));
      }
    }
  }
}
