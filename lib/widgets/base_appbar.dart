import 'package:flutter/material.dart';

import '../app/constant.dart';
import '../app/theme.dart';

class BaseAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actionWidget;
  final bool centerTitle;
  final Color backgroundColor;
  final Color textColor;

  const BaseAppbar(
      {super.key,
      required this.title,
      this.actionWidget,
      this.centerTitle = true,
      this.textColor = netralColor10,
      this.backgroundColor = primaryMainColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(title,
          style: textLargeMedium(context: context)
              .copyWith(color: textColor, fontWeight: FontWeight.w600)),
      actions: actionWidget,
      foregroundColor: textColor,
      toolbarHeight: getActualY(context: context, y: 100),
      shadowColor: Colors.white.withOpacity(0.08),
      backgroundColor: backgroundColor,
    );
  }

  @override
  // ignore: todo
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
