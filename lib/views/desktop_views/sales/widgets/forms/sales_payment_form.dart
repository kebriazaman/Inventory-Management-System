import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/controllers/desktop/sales_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/action_button.dart';

class SalesPaymentForm extends StatelessWidget {
  const SalesPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesController salesController = Get.find<SalesController>();
    final CustomerController customerController = Get.find<CustomerController>();
    return SizedBox(
      height: Get.height * 0.55,
      width: Get.width * 0.3,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: salesController.paymentFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text('Payment Type',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700))),
                  Expanded(
                    child: Obx(
                      () => DropdownButton(
                        autofocus: true,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        focusNode: salesController.paymentTypeFocusNode,
                        value: salesController.paymentType.value,
                        style: Theme.of(context).textTheme.bodySmall,
                        onChanged: (v) {
                          if (v != 'Select') {
                            salesController.setPaymentType(v.toString());
                            Utils.fieldFocusChange(
                                context, salesController.paymentTypeFocusNode, salesController.cashFocusNode);
                          }
                        },
                        items: <String>['Select', ' Cash', 'Easypaisa ', 'Jazz Cash'] // List of dropdown items
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value), // Displayed dropdown item
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Collected Amount',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: salesController.cashFocusNode,
                      controller: salesController.cashController,
                      decoration: kTextInputFieldDecoration.copyWith(
                        hintText: '0.00',
                      ),
                      onFieldSubmitted: (_) => Utils.fieldFocusChange(
                          context, salesController.cashFocusNode, salesController.changeFocusNode),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.integer(errorText: 'Please enter integer value'),
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text('Change Amount',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700))),
                  Expanded(
                    child: TextFormField(
                      controller: salesController.changeController,
                      focusNode: salesController.changeFocusNode,
                      decoration: kTextInputFieldDecoration.copyWith(
                        hintText: '0.00',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.integer(errorText: 'Please enter integer value'),
                        FormBuilderValidators.required(),
                      ]),
                      onFieldSubmitted: (_) => Utils.fieldFocusChange(
                          context, salesController.changeFocusNode, salesController.saveButtonFocusNode),
                    ),
                  ),
                ],
              ),
              10.height,
              Row(
                children: [
                  ActionButton(
                    text: 'Cancel',
                    onPress: () {
                      salesController.clearData();
                      Get.back();
                    },
                    buttonStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.redColor.withOpacity(0.9))),
                  ),
                  10.width,
                  Obx(
                    () => ActionButton(
                      isLoading: salesController.isButtonLoading.value,
                      text: 'Submit',
                      focusNode: salesController.saveButtonFocusNode,
                      onPress: salesController.isButtonLoading.value
                          ? null
                          : () async {
                              if (salesController.paymentFormKey.currentState!.validate()) {
                                await salesController.saveSale(customerController.customer.toString());
                              }
                            },
                      buttonStyle: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.appButtonColor.withOpacity(0.9))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
