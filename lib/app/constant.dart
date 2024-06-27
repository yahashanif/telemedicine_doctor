import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'theme.dart';

double designHeightPhone = 844;
double designWidthPhone = 390;

double defaultMargin = 24;

List<String> listDay = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu'
];

String getMoney(
    {required dynamic money, String locale = 'id_ID', String symbol = "Rp. "}) {
  return NumberFormat.currency(
    locale: locale,
    symbol: symbol,
    decimalDigits: 0,
  ).format(
    money,
  );
}

double getLineHeight({required double fontSize, required double lineHight}) {
  return lineHight / fontSize;
}

String colorToString(Color color) {
  // Use the RGB values to create a string representation
  return 'rgb(${color.red}, ${color.green}, ${color.blue})';
}

Color stringToColor(String colorString) {
  // Remove 'rgb(' and ')' from the string
  colorString = colorString.replaceAll('rgb(', '').replaceAll(')', '');

  // Split the string into a list of RGB values
  List<String> rgbValues = colorString.split(',');

  // Extract the individual RGB values
  int red = int.parse(rgbValues[0].trim());
  int green = int.parse(rgbValues[1].trim());
  int blue = int.parse(rgbValues[2].trim());

  // Create a Color object
  return Color.fromARGB(255, red, green, blue);
}

BoxShadow defaultBoxShadow = BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    color: netralColor100.withOpacity(0.12));
double getActualX({
  required double x,
  required BuildContext context,
}) {
  return x / designWidthPhone * MediaQuery.of(context).size.width;
}

double getActualY({
  required double y,
  required BuildContext context,
}) {
  return y / designHeightPhone * MediaQuery.of(context).size.height;
}

String formatTime(String timeString) {
  List<String> timeComponents = timeString.split(':');

  // Memastikan dua digit untuk jam dan menit
  String hour = timeComponents[0].padLeft(2, '0');
  String minute = timeComponents[1].padLeft(2, '0');

  // Format waktu menggunakan intl.DateFormat
  final formatter = DateFormat('HH:mm');

  return formatter
      .format(DateTime(0, 0, 0, int.parse(hour), int.parse(minute)));
}

String formatTanggalView(
    {required String tanggal,
    String format = 'dd/MM/yyyy',
    String? errorMessage}) {
  try {
    DateTime originalDate = DateTime.parse(tanggal);
    String formattedDate = DateFormat(format, "id_ID").format(originalDate);
    return formattedDate;
  } catch (e) {
    // Tangani kesalahan jika format tanggal tidak valid
    return errorMessage ?? "Tanggal tidak valid";
  }
}

String formatTanggal(String tanggal) {
  try {
    DateTime originalDate = DateTime.parse(tanggal);
    String formattedDate = DateFormat('dd/MM/yyyy').format(originalDate);
    return formattedDate;
  } catch (e) {
    // Tangani kesalahan jika format tanggal tidak valid
    return "Tanggal tidak valid";
  }
}

List<TextSpan> buildTextSpans(
    BuildContext context, String searchData, String text,
    {TextStyle? textStyle}) {
  List<TextSpan> textSpans = [];
  if (searchData != '') {
    final RegExp regExp = RegExp(searchData, caseSensitive: false);
    final Iterable<Match> matches = regExp.allMatches(text);
    int start = 0;
    for (Match match in matches) {
      (textSpans);
      if (match.start > start) {
        textSpans.add(TextSpan(
          style: textStyle!.copyWith(color: netralColor100),
          text: text.substring(start, match.start),
        ));
      }
      textSpans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: textStyle,
      ));
      start = match.end;
    }
    if (start < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(start),
      ));
    }
  } else {
    textSpans.add(TextSpan(text: text));
  }
  return textSpans;
}

String maskEmail(String emailAddress) {
  int atIndex = emailAddress.indexOf('@');
  if (atIndex != -1 && atIndex > 3) {
    String masked =
        "${emailAddress.substring(0, atIndex - 3).replaceAll(RegExp(r'.'), '*')}${emailAddress.substring(atIndex - 3)}";
    return masked;
  }
  return emailAddress;
}

String maskCardNumber(String cardNumber) {
  if (cardNumber.length < 4) {
    return cardNumber;
  }
  String maskedNumber =
      '*********${cardNumber.substring(cardNumber.length - 4)}';
  return maskedNumber;
}

String toCamelCase(String text) {
  List<String> words = text.split(' ');
  String camelCaseText = '';

  for (int i = 0; i < words.length; i++) {
    // Uppercase huruf pertama pada setiap kata.
    camelCaseText +=
        words[i].substring(0, 1).toUpperCase() + words[i].substring(1);

    // Tambahkan spasi di antara setiap kata, kecuali pada kata terakhir.
    if (i != words.length - 1) {
      camelCaseText += ' ';
    }
  }

  return camelCaseText;
}


//  ListView(
//         children: [
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textXSmallReguler(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textXSmallMedium(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textXSmallSemiBold(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textXSmallBold(context: context),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textSmallLight(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textSmallReguler(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textSmallMedium(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textSmallSemiBold(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textSmallBold(context: context),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textMediumLight(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textMediumReguler(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textMediumMedium(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textMediumSemiBold(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textMediumBold(context: context),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textLargeLight(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textLargeReguler(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textLargeMedium(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textLargeSemiBold(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: textLargeBold(context: context),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: headingSmall(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: headingMedium(context: context),
//           ),
//           Text(
//             "Kamu ke kanan bola ke kiri. Mantan udah nikahan kamu masih sendiri.",
//             style: headingLarge(context: context),
//           ),
//         ],
//       ),