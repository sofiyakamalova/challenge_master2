import 'package:challenge_master/src/core/common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.deepOrangeAccent,
    this.fontWeight,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CommonTitle(title: title),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
