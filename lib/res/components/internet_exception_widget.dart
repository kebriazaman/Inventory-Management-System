import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatefulWidget {
  VoidCallback onPressed;
  InternetExceptionWidget({required this.onPressed, Key? key}) : super(key: key);

  @override
  State<InternetExceptionWidget> createState() => _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off, color: Colors.red, size: 100),
              Text(
                'No Internet Connection',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
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
