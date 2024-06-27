// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../app/constant.dart';
import '../../app/theme.dart';

class CardMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const CardMenu({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: getActualY(context: context, y: 4)),
        padding: EdgeInsets.symmetric(
            horizontal: getActualX(context: context, x: 12),
            vertical: getActualY(context: context, y: 12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: primaryMainColor,
                  size: getActualY(context: context, y: 20),
                ),
                SizedBox(
                  width: getActualX(context: context, x: 12),
                ),
                Text(
                  title,
                  style: textMediumMedium(context: context)
                      .copyWith(color: textPrimary),
                )
              ],
            ),
            Icon(Icons.keyboard_arrow_right_outlined)
          ],
        ),
      ),
    );
  }
}
