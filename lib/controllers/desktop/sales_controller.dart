import 'dart:convert';
import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/models/category_model.dart';
import 'package:pos_fyp/models/products/products_model.dart';
import 'package:pos_fyp/models/sales/sales_items_model.dart';
import 'package:pos_fyp/models/sales/selectedProductModel.dart';
import 'package:pos_fyp/utils/utils.dart';

class SalesController extends GetxController {
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SelectedProductModel> selectedProducts = <SelectedProductModel>[].obs;
  RxList<SalesItemsModel> salesItems = <SalesItemsModel>[].obs;
  RxList<ProductsModel> filteredProducts = <ProductsModel>[].obs;
  RxList<String> salesItemsId = <String>[].obs;

  final GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();

  final RxString _paymentType = RxString('Select');

  final RxDouble _tax = RxDouble(0.0); // 1% tax
  final RxDouble _discount = RxDouble(0.0); // 1% discount
  final RxDouble _total = RxDouble(0.0);
  final RxDouble _service = RxDouble(0.0);
  final RxDouble _subTotal = RxDouble(0.0);
  final RxInt _selectedIndex = 0.obs;
  final RxInt _selectedRowIndex = RxInt(-1);
  final RxBool _isLoading = false.obs;
  final RxBool _isButtonLoading = false.obs;

  RxString get paymentType => _paymentType;
  RxDouble get subTotal => _subTotal;
  RxInt get selectedIndex => _selectedIndex;
  RxInt get selectedRowIndex => _selectedRowIndex;
  RxDouble get total => _total;
  RxDouble get tax => _tax;
  RxDouble get discount => _discount;
  RxDouble get service => _service;
  RxBool get isButtonLoading => _isButtonLoading;

  RxBool get isLoading => _isLoading;

  setPaymentType(String value) => _paymentType.value = value;
  setSelectedIndex(int index) => _selectedIndex.value = index;
  setSelectedRowIndex(int index) => _selectedRowIndex.value = index;
  setLoading(bool value) => _isLoading.value = value;
  setTotal(double value) => _total.value = value;
  setSubTotal(double value) => _subTotal.value = value;
  setTax(double value) => _tax.value = value;
  setDiscount(double value) => _discount.value = value;
  setService(double value) => _service.value = value;
  setButtonLoading(bool value) => _isButtonLoading.value = value;

  TextEditingController cashController = TextEditingController();
  TextEditingController changeController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  FocusNode paymentTypeFocusNode = FocusNode();
  FocusNode cashFocusNode = FocusNode();
  FocusNode changeFocusNode = FocusNode();
  FocusNode discountFocusNode = FocusNode();
  FocusNode saveButtonFocusNode = FocusNode();

  @override
  void onInit() async {
    super.onInit();
    setLoading(true);
    await fetchAllProducts();
  }

  Future<void> updateProductsStatus(var product) async {
    QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))
      ..whereEqualTo('objectId', product.id)
      ..includeObject(['category']);
    ParseResponse res = await queryBuilder.query();
    if (res.success && res.results != null) {
      ParseObject object = res.results!.first;
      int productQuantity = int.parse(object.get('quantity'));
      int qty = productQuantity - int.parse(product.qty!.value.toString());
      object.set('quantity', qty.toString());
      object.get('quantity') == '0' ? object.set('status', 'out-of-stock') : object.set('status', 'available');
      print(object.get('status'));
      ParseResponse parseResponse = await object.save();
      if (parseResponse.success && parseResponse.results != null) {
        updateProductInList(product.id, qty.toString());
        print('updated');
      } else {
        print(parseResponse.error!.message);
      }
    }
  }

  Future<void> saveSale(String customerName) async {
    salesItems.clear();
    setButtonLoading(true);
    for (var product in selectedProducts) {
      ParseObject salesItemObject = ParseObject('SalesItems')
        ..set('product', (ParseObject('Products')..objectId = product.id).toPointer())
        ..set('quantity', product.qty!.value.toString())
        ..set('netPrice', double.parse(product.netPrice!).toStringAsFixed(2));
      ParseResponse itemsResponse = await salesItemObject.save();
      if (itemsResponse.success && itemsResponse.results != null) {
        salesItems.add(SalesItemsModel.fromJson(jsonDecode(itemsResponse.results!.first.toString())));
        updateProductsStatus(product);
      } else {
        setButtonLoading(false);
        print(itemsResponse.error!.message);
      }
    }

    // ****************** save sale ********************* //
    QueryBuilder<ParseObject> queryCustomer = QueryBuilder<ParseObject>(ParseObject('Customers'))
      ..whereEqualTo('name', customerName);
    ParseResponse response = await queryCustomer.query();
    if (response.success) {
      final customerResponse = response.results!.first;
      final objectId = customerResponse.get('objectId');

      try {
        ParseObject newSale = ParseObject('Sales')
          ..set('customer', (ParseObject('Customers')..objectId = objectId).toPointer())
          ..set('paymentType', paymentType.value)
          ..set('collectedAmount', cashController.text.trim())
          ..set('changeAmount', changeController.text.trim())
          ..set('subtotal', subTotal.toStringAsFixed(2))
          ..set('discount', discount.toStringAsFixed(2))
          ..set('tax', tax.toStringAsFixed(2))
          ..set('service', service.toString())
          ..set('grandTotal', total.toStringAsFixed(2));

        newSale.addRelation('salesItems',
            salesItems.map((element) => ParseObject('SalesItems')..set('objectId', element.objectId)).toList());

        ParseResponse salesResponse = await newSale.save();
        if (salesResponse.success && salesResponse.results != null) {
          setButtonLoading(false);
          Get.back();
          clearData();
        } else {
          print(salesResponse.success);
          print(salesResponse.error!.message);
          setButtonLoading(false);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // void getSelectedItems(String name) {
  //   salesItemsIds.where((element) => element)
  // }

  void updateProductInList(String? productId, String newQtyValue) {
    int index = filteredProducts.indexWhere((element) => element.objectId == productId);
    filteredProducts[index].quantity = newQtyValue;
  }

  Future<void> saveNewSale(String customerName) async {
    setButtonLoading(true);
    QueryBuilder<ParseObject> queryCustomer = QueryBuilder<ParseObject>(ParseObject('Customers'))
      ..whereEqualTo('name', customerName);
    ParseResponse response = await queryCustomer.query();
    if (response.success && response.results != null) {
      final customerResponse = response.results!.first;
      final objectId = customerResponse.get('objectId');
      ParseObject newSale = ParseObject('Sales')
        ..set('customer', (ParseObject('Customers')..objectId = objectId).toPointer())
        ..set('paymentType', paymentType.value)
        ..set('collectedAmount', cashController.text.trim())
        ..set('changeAmount', changeController.text.trim())
        ..set('subtotal', subTotal.toStringAsFixed(2))
        ..set('discount', discount.toStringAsFixed(2))
        ..set('tax', tax.toStringAsFixed(2))
        ..set('service', service.toString())
        ..set('grandTotal', total.toString());

      ParseResponse salesResponse = await newSale.save();

      if (salesResponse.success && salesResponse.results != null) {
        for (var product in selectedProducts) {
          ParseObject soldItems = ParseObject('SalesItems')
            ..set('product', (ParseObject('Products')..objectId = product.id).toPointer())
            ..set('quantity', product.qty!.value.toString())
            ..set('netPrice', product.netPrice.toString())
            ..set('sales', (ParseObject('Sales')..objectId = newSale.objectId).toPointer());
          ParseResponse itemsResponse = await soldItems.save();
          if (itemsResponse.success && itemsResponse.results != null) {
            QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))
              ..whereEqualTo('objectId', product.id)
              ..includeObject(['category']);

            ParseResponse res = await queryBuilder.query();
            if (res.success && res.results != null) {
              for (var element in res.results!) {
                print(element);
              }
              ParseObject object = res.results!.first;
              int productQuantity = int.parse(object.get('quantity'));
              int qty = productQuantity - product.qty!.value;
              object.set('quantity', qty.toString());
              ParseResponse parseResponse = await object.save();
              if (parseResponse.success && parseResponse.results != null) {
                setButtonLoading(false);
                clearData();
              } else {
                setButtonLoading(false);
                Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
              }
            } else {
              setButtonLoading(false);
              Utils.showDialogueMessage('fError', res.error!.message, Icons.error_outline);
            }
          } else {
            setButtonLoading(false);
            Utils.showDialogueMessage('Error', itemsResponse.error!.message, Icons.error_outline);
          }
        }
      } else {
        setButtonLoading(false);
        Utils.showDialogueMessage('Error', salesResponse.error!.message, Icons.error_outline);
      }
    } else {
      setButtonLoading(false);
      Utils.showDialogueMessage('Error', response.error!.message, Icons.error_outline);
    }
    await fetchAllProducts();
    Get.back();
  }

  Future<void> fetchAllProducts() async {
    setLoading(true);
    try {
      QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Products'))
        ..includeObject(['category'])
        ..orderByDescending('createdAt');
      ParseResponse parseResponse = await queryBuilder.query();
      if (parseResponse.success && parseResponse.results != null) {
        products.value = mapProductsToList(parseResponse.results.toString());
        filteredProducts.assignAll(products);
        await fetchAllCategories();
        setLoading(false);
      } else {
        setLoading(false);

        Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
      }
    } on SocketException catch (e) {
      setLoading(false);
      Utils.showDialogueMessage('Error', e.message, Icons.error_outline);
    }
  }

  Future<void> fetchAllCategories() async {
    try {
      QueryBuilder<ParseObject> queryBuilder = QueryBuilder(ParseObject('Category'))..orderByDescending('createdAt');
      ParseResponse parseResponse = await queryBuilder.query();
      if (parseResponse.success && parseResponse.results != null) {
        categories.value = mapCategoriesToList(parseResponse.results.toString());
      } else {
        Utils.showDialogueMessage('Error', parseResponse.error!.message, Icons.error_outline);
      }
    } on SocketException catch (e) {
      Utils.showDialogueMessage('Error', e.message, Icons.error_outline);
    }
  }

  Future<void> fetchProductsByCategory(String id) async {
    if (selectedIndex.value == 0) {
      filteredProducts.value = products;
      return;
    } else {
      filteredProducts.value =
          products.where((element) => element.category.objectId.toLowerCase().contains(id.toLowerCase())).toList();
    }
  }

  Future<void> filterProducts(String text) async {
    if (text == '') {
      filteredProducts.assignAll(products);
    } else {
      var searchedProducts =
          products.where((element) => element.name.toLowerCase().contains(text.toLowerCase())).toList();
      filteredProducts.assignAll(searchedProducts);
    }
  }

  void removeSelectedElement(ProductsModel product) {
    if (selectedProducts.isNotEmpty) {
      var element = selectedProducts.firstWhere((element) => element.id == product.objectId);
      selectedProducts.remove(element);
      recalculateProductSummary(element);
    }
  }

  void addSelectedElement(ProductsModel product) {
    var selected = SelectedProductModel(
        product.objectId, product.name, product.netValue, 0.obs, product.netValue, int.parse(product.quantity));
    selectedProducts.add(selected);
    calculateProductSummary(selected);
  }

  void calculateProductSummary(SelectedProductModel selectedProduct) {
    if (selectedProduct.qty!.value < selectedProduct.inStockQty!) selectedProduct.qty?.value += 1;
    if (selectedProduct.qty!.value >= 1) {
      double productNetPrice = selectedProduct.qty!.value * double.parse(selectedProduct.price.toString());
      selectedProduct.netPrice = productNetPrice.toString();
      // subtotal
      double totalProductsPrice = selectedProducts.fold(
          0, (previousValue, element) => previousValue + double.parse(element.netPrice.toString()).toInt());
      setSubTotal(totalProductsPrice);
      // discount
      double discountRate = 1 / 100; // 1% discount sale
      double discountValue = subTotal.value * discountRate;
      setDiscount(discountValue);

      // service

      double serviceValue = 1.0;
      setService(serviceValue);

      // Total price
      double total = ((subTotal.value - discountValue) + serviceValue);

      // tax
      double taxRate = 5 / 100; // 5% tax per sale
      double taxValue = total * taxRate;
      setTax(taxValue);
      double grandTotal = total + taxValue;
      setTotal(grandTotal);
    }
  }

  SelectedProductModel recalculateProductSummary(SelectedProductModel selectedProduct) {
    if (selectedProduct.qty!.value > 0) {
      selectedProduct.qty!.value -= 1;
      double productNetPrice = selectedProduct.qty!.value * double.parse(selectedProduct.price.toString());
      selectedProduct.netPrice = productNetPrice.toString();
      // subtotal
      double totalProductsPrice = selectedProducts.fold(
          0, (previousValue, element) => previousValue + double.parse(element.netPrice.toString()).toInt());
      setSubTotal(totalProductsPrice);
      // discount
      double discountRate = 1 / 100; // 1% discount sale
      double discountValue = subTotal.value * discountRate;
      setDiscount(discountValue);

      // tax
      double taxRate = 1 / 100; // 1% tax per sale
      double taxValue = subTotal.value * taxRate;
      setTax(taxValue);

      // service
      double serviceRate = 5 / 100; // 5% service
      double serviceValue = subTotal.value * serviceRate;
      setService(serviceValue);

      // Total price
      double grandTotal = ((subTotal.value + (taxValue + serviceValue)) - discountValue);
      setTotal(grandTotal);
    }
    return selectedProduct;
  }

  dynamic mapProductsToList(dynamic response) {
    var data = jsonDecode(response);
    var mappedData = (data as List).map((e) => ProductsModel.fromJson(e)).toList();
    return mappedData;
  }

  dynamic mapCategoriesToList(dynamic response) {
    var data = jsonDecode(response);
    var mappedData = (data as List).map((e) => CategoryModel.fromJson(e)).toList();
    return mappedData;
  }

  dynamic mapSalesItemsToList(dynamic response) {
    var data = jsonDecode(response);
    var mappedData = (data as List).map((e) => SalesItemsModel.fromJson(e)).toList();
    return mappedData;
  }

  List<DataColumn2> dataTableColumns = [
    const DataColumn2(label: Text('id')),
    const DataColumn2(label: Text('name')),
    const DataColumn2(label: Text('category')),
    const DataColumn2(label: Text('quantity')),
    const DataColumn2(label: Text('price')),
    const DataColumn2(label: Text('status')),
    const DataColumn2(label: Text('Manufacturer')),
  ];

  void clearData() {
    selectedProducts.clear();
    setSubTotal(0);
    setTax(0);
    setService(0);
    setDiscount(0);
    setPaymentType('Select');
    setTotal(0);
    cashController.clear();
    changeController.clear();
    discountController.clear();
  }
}
