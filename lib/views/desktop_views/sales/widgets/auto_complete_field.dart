import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/controllers/customer_controller.dart';
import 'package:pos_fyp/models/customers_model.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/utils/constants.dart';
import 'package:pos_fyp/views/desktop_views/sales/widgets/forms/add_customer_form.dart';

class AutoCompleteField extends StatelessWidget {
  const AutoCompleteField({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.put(CustomerController());
    return Expanded(
      child: TypeAheadField<CustomersModel>(
        suggestionsCallback: customerController.fetchAllCustomers,
        onSelected: (CustomersModel customer) {
          customerController.setCustomerValue(customer.name.toString());
          customerController.customerEditingController.text = customer.name.toString();
        },
        builder: (context, controller, focusNode) => TextFormField(
          controller: customerController.customerEditingController,
          focusNode: focusNode,
          decoration: kAppbarTextFieldDecoration.copyWith(
            labelText: 'Search Customers',
            labelStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: IconButton(
                highlightColor: AppColors.transparentColor,
                hoverColor: AppColors.transparentColor,
                padding: const EdgeInsets.only(left: 8.0),
                onPressed: () {
                  Get.defaultDialog(
                    barrierDismissible: false,
                    title: 'Add Customer',
                    content: const AddCustomerForm(),
                  );
                },
                icon: const Icon(Icons.add, size: 20.0)),
          ),
        ),
        debounceDuration: const Duration(milliseconds: 300),
        decorationBuilder: (context, child) {
          return Material(
            color: AppColors.whiteColor,
            type: MaterialType.canvas,
            elevation: 4,
            borderRadius: BorderRadius.circular(4),
            child: child,
          );
        },
        offset: const Offset(0, 12),
        constraints: const BoxConstraints(maxHeight: 300),
        loadingBuilder: (context) => const SizedBox(height: 50, child: Center(child: Text('Loading...'))),
        errorBuilder: (context, error) => const SizedBox(height: 50, child: Center(child: Text('Error!'))),
        emptyBuilder: (context) => const SizedBox(height: 50, child: Center(child: Text('No Customer found!'))),
        itemBuilder: (context, value) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              title: Text(
                value.name.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                value.phoneNo.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w300),
              ),
            ),
          );
        },
      ),
    );
  }
}
