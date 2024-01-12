import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/action_button.dart';

class CustomerForm extends StatelessWidget {
  const CustomerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.find<CustomerController>();
    return SizedBox(
      width: Get.width * 0.5,
      height: Get.height * 0.5,
      child: FormBuilder(
        key: customerController.customerFormKey2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: customerController.nameController,
                    textInputAction: TextInputAction.next,
                    cursorColor: AppColors.blackColor,
                    keyboardType: TextInputType.text,
                    decoration: kTextFormFieldDecoration.copyWith(
                        labelText: 'Name',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        prefixIcon: const Icon(Icons.person)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value!.isEmpty || GetUtils.isLengthLessThan(value, 3) ? 'Invalid name entered' : null,
                  ),
                )
              ]),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: customerController.phoneNoController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Phone Number'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => GetUtils.isLengthLessThan(value, 0) || !GetUtils.isNum(value.toString())
                          ? 'Enter the phone number'
                          : null,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      controller: customerController.emailController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.number,
                      decoration: kTextFormFieldDecoration.copyWith(labelText: 'Email Address'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: customerController.cityController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.text,
                      decoration: kTextFormFieldDecoration.copyWith(
                          labelText: 'City', labelStyle: Theme.of(context).textTheme.bodySmall),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: TextFormField(
                      controller: customerController.addressController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.blackColor,
                      keyboardType: TextInputType.text,
                      decoration: kTextFormFieldDecoration.copyWith(
                          labelText: 'Address', labelStyle: Theme.of(context).textTheme.bodySmall),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onFieldSubmitted: (_) => Utils.fieldFocusChange(
                          context, customerController.addressFocusNode, customerController.saveButtonFocusNode),
                    ),
                  ),
                ],
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButton(
                    text: 'Cancel',
                    onPress: () {
                      customerController.clearEditingControllers();
                      Get.back();
                    },
                    buttonStyle: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(const Size(120, 30)),
                        backgroundColor: MaterialStateProperty.all(AppColors.cancelButtonColor)),
                  ),
                  5.width,
                  Obx(
                    () => ActionButton(
                      isLoading: customerController.isCustomerLoading.value,
                      focusNode: customerController.saveButtonFocusNode,
                      text: 'Save',
                      onPress: () async {
                        // Utils.generatePdf();
                        if (customerController.customerFormKey2.currentState!.validate()) {
                          await customerController.saveCustomer();
                          customerController.clearEditingControllers();
                          Get.back();
                        }
                        //   final pdf = pw.Document();
                        //   pdf.addPage(
                        //     pw.MultiPage(
                        //       pageFormat: PdfPageFormat.a4,
                        //       build: (pw.Context context) => [
                        //         // build title
                        //         pw.Column(children: [
                        //           pw.Text('Hello', style: pw.TextStyle(fontSize: 32)),
                        //         ]),
                        //       ],
                        //     ),
                        //   );
                        //
                        //   final dir = await getApplicationDocumentsDirectory();
                        //   final file = File('${dir.path}/example.pdf');
                        //   await file.writeAsBytes(await pdf.save());
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewPdf(pdf: pdf)));
                        // },
                      },
                      buttonStyle: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(120, 30)),
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
