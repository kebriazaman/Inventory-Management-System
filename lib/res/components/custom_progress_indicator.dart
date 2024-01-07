import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  CustomProgressIndicator({required this.width, required this.height, required this.color, super.key});
  double width;
  double height;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: color)));
  }
}
