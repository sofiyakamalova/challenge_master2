import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const BuildButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColor.secondMainColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
