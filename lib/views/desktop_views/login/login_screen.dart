import 'package:flutter/material.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';

import './widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    ImageAssets.loginInventoryImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: LoginFormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
