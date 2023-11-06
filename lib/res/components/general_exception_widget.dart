import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralExceptionWidget extends StatefulWidget {
  const GeneralExceptionWidget({Key? key}) : super(key: key);

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.15),
              Icon(Icons.cloud_off, color: Colors.red, size: 50),
              Text(
                'We are unable to process your request!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.15),
              TextButton(
                onPressed: () {},
                child: Text('Retry'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                  minimumSize: Size(100, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
