import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_fyp/views/desktop_views/signup/widgets/signup_form_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              height: Get.height,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/signup_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: Get.width * .4,
              height: Get.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  bottomLeft: Radius.circular(32.0),
                ),
              ),
              child: SignupFormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
