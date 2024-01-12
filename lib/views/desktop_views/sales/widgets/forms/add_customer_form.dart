import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/utils/extensions.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/action_button.dart';

class AddCustomerForm extends StatelessWidget {
  const AddCustomerForm({required this.customerController, super.key});
  final CustomerController customerController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.6,
      width: Get.width * 0.2,
      child: FormBuilder(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: customerController.customerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FormBuilderTextField(
                autofocus: true,
                controller: customerController.nameController,
                focusNode: customerController.nameFocusNode,
                name: 'name',
                decoration:
                    kSignupInputFieldDecoration.copyWith(hintText: 'Name', prefixIcon: const Icon(Icons.short_text)),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3, errorText: 'Enter valid name')
                ]),
                onSubmitted: (v) => Utils.fieldFocusChange(
                    context, customerController.nameFocusNode, customerController.phoneFocusNode),
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                controller: customerController.phoneNoController,
                focusNode: customerController.phoneFocusNode,
                name: 'phoneNo',
                decoration:
                    kSignupInputFieldDecoration.copyWith(hintText: 'Phone number', prefixIcon: const Icon(Icons.phone)),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(errorText: 'Phone number should be integer value'),
                ]),
                onSubmitted: (v) => Utils.fieldFocusChange(
                    context, customerController.phoneFocusNode, customerController.emailFocusNode),
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                controller: customerController.emailController,
                focusNode: customerController.emailFocusNode,
                name: 'email',
                decoration: kSignupInputFieldDecoration.copyWith(
                    hintText: 'Email', prefixIcon: const Icon(Icons.email_outlined)),
                onSubmitted: (v) => Utils.fieldFocusChange(
                    context, customerController.emailFocusNode, customerController.cityFocusNode),
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                controller: customerController.cityController,
                focusNode: customerController.cityFocusNode,
                name: 'city',
                decoration:
                    kSignupInputFieldDecoration.copyWith(hintText: 'City', prefixIcon: const Icon(Icons.location_city)),
                onSubmitted: (v) => Utils.fieldFocusChange(
                    context, customerController.cityFocusNode, customerController.addressFocusNode),
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                controller: customerController.addressController,
                focusNode: customerController.addressFocusNode,
                name: 'address',
                decoration: kSignupInputFieldDecoration.copyWith(
                    hintText: 'Address', prefixIcon: const Icon(Icons.location_on_outlined)),
                onSubmitted: (v) => Utils.fieldFocusChange(
                    context, customerController.addressFocusNode, customerController.saveButtonFocusNode),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  ActionButton(
                    text: 'Cancel',
                    onPress: () {
                      Get.delete<CustomerController>();
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
                        if (customerController.customerFormKey.currentState!.validate()) {
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
                          fixedSize: MaterialStateProperty.all(const Size(120, 30)),
                          backgroundColor: MaterialStateProperty.all(AppColors.appButtonColor.withOpacity(0.9))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
