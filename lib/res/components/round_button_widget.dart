import 'package:flutter/material.dart';
import 'package:pos_fyp/res/app_color.dart';

class RoundButtonWidget extends StatefulWidget {
  RoundButtonWidget(
      {Key? key,
      required this.title,
      required this.isLoading,
      this.width = 70,
      this.height = 70,
      this.textColor = AppColors.buttonTextColor,
      this.backgroundColor = AppColors.buttonBackgroundColor,
      required this.onTap})
      : super(key: key);

  final String title;
  void Function() onTap;
  final bool isLoading;
  final double width, height;
  final Color textColor, backgroundColor;

  @override
  State<RoundButtonWidget> createState() => _RoundButtonWidgetState();
}

class _RoundButtonWidgetState extends State<RoundButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: AppColors.whiteColor,
      splashColor: AppColors.whiteColor,
      focusColor: AppColors.whiteColor,
      highlightColor: AppColors.whiteColor,
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(color: AppColors.greyColor, blurRadius: 1),
            ]),
        child: widget.isLoading
            ? const CircularProgressIndicator(color: AppColors.whiteColor)
            : Center(
                child: Text(widget.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: widget.textColor)),
              ),
      ),
    );
  }
}
