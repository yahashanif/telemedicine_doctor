import 'package:flutter/material.dart';

import 'constant.dart';

const Color primaryMainColor = Color(0xff19BBBB);
const Color primarySurfaceColor = Color(0xffD5F1F1);
const Color primaryBorderColor = Color(0xffB2E8E8);
const Color primaryHoverColor = Color(0xff159C9C);
const Color primaryPresedColor = Color(0xff117D7D);
const Color primaryFokusColor = Color(0xff19BBBB);

//
const Color netralColor = Color(0xFFF5F5F5);
const Color netralColor10 = Color(0xffFFFFFF);
const Color netralColor20 = Color(0xffF5F5F5);
const Color netralColor30 = Color(0xffEDEDED);
const Color netralColor40 = Color(0xffE0E0E0);
const Color netralColor50 = Color(0xffC2C2C2);
const Color netralColor60 = Color(0xff9E9E9E);
const Color netralColor70 = Color(0xff757575);
const Color netralColor80 = Color(0xff616161);
const Color netralColor90 = Color(0xff404040);
const Color netralColor100 = Color(0xff0A0A0A);

//
const Color successMainColor = Color(0xff43936C);
const Color successSurgaceColor = Color(0xffF7F7F7);
const Color successBorderColor = Color(0xffB8DBCA);
const Color successHoverColor = Color(0xff367A59);
const Color successPressedColor = Color(0xff20573D);
//
const Color warningMainColor = Color(0xffCD7B2E);
const Color warningSurgaceColor = Color(0xffFFF9F2);
const Color warningBorderColor = Color(0xffEECEB0);
const Color warningHoverColor = Color(0xffBF6919);
const Color warningPressedColor = Color(0xff734011);
//
const Color dangerMainColor = Color(0xffCB3A31);
const Color dangerSurgaceColor = Color(0xffFFF4F2);
const Color dangerBorderColor = Color(0xffEEB4B0);
const Color dangerHoverColor = Color(0xffBD251C);
const Color dangerPressedColor = Color(0xff731912);

const Color labelColor = Color(0xff637381);
const Color textPrimary = Color(0xff212B36);
const Color textDisable = Color(0xff919EAB);

const Color colorShadow = Color.fromARGB(255, 113, 118, 127);

List<BoxShadow> shadows = [
  BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4,
      color: colorShadow.withOpacity(0.12)),
  BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 2,
      spreadRadius: 0,
      color: colorShadow.withOpacity(0.20))
];

TextStyle textXSmallReguler({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 11,
      context: context,
    ),
  );
}

TextStyle textXSmallMedium({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w500,
    fontSize: getActualY(
      y: 11,
      context: context,
    ),
  );
}

TextStyle textXSmallSemiBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w600,
    fontSize: getActualY(
      y: 11,
      context: context,
    ),
  );
}

TextStyle textXSmallBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w700,
    fontSize: getActualY(
      y: 11,
      context: context,
    ),
  );
}
//

TextStyle textSmallLight({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w300,
    fontSize: getActualY(
      y: 12,
      context: context,
    ),
  );
}

TextStyle textSmallReguler({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 12,
      context: context,
    ),
  );
}

TextStyle textSmallMedium({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w500,
    fontSize: getActualY(
      y: 12,
      context: context,
    ),
  );
}

TextStyle textSmallSemiBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w600,
    fontSize: getActualY(
      y: 12,
      context: context,
    ),
  );
}

TextStyle textSmallBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w700,
    fontSize: getActualY(
      y: 12,
      context: context,
    ),
  );
}

TextStyle textMediumLight({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w300,
    fontSize: getActualY(
      y: 14,
      context: context,
    ),
  );
}

TextStyle textMediumReguler({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 14,
      context: context,
    ),
  );
}

TextStyle textMediumMedium({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w500,
    fontSize: getActualY(
      y: 14,
      context: context,
    ),
  );
}

TextStyle textMediumSemiBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w600,
    fontSize: getActualY(
      y: 14,
      context: context,
    ),
  );
}

TextStyle textMediumBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w700,
    fontSize: getActualY(
      y: 14,
      context: context,
    ),
  );
}

TextStyle textLargeLight({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w300,
    fontSize: getActualY(
      y: 16,
      context: context,
    ),
  );
}

TextStyle textLargeReguler({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 16,
      context: context,
    ),
  );
}

TextStyle textLargeMedium({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w500,
    fontSize: getActualY(
      y: 16,
      context: context,
    ),
  );
}

TextStyle textLargeSemiBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w600,
    fontSize: getActualY(
      y: 16,
      context: context,
    ),
  );
}

TextStyle textLargeBold({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w700,
    fontSize: getActualY(
      y: 16,
      context: context,
    ),
  );
}

TextStyle headingSmall({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 20,
      context: context,
    ),
  );
}

TextStyle headingMedium({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 28,
      context: context,
    ),
  );
}

TextStyle headingLarge({required BuildContext context}) {
  return TextStyle(
    fontFamily: 'Poppins Reguler',
    color: netralColor100,
    fontWeight: FontWeight.w400,
    fontSize: getActualY(
      y: 36,
      context: context,
    ),
  );
}
