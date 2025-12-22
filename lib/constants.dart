import 'package:flutter/material.dart';

const Color greyDark = Color(0xFF2B323A);
const Color greenMainColor = Color(0xFF27CA84);
const Color blue = Color(0xFF0091FA);

TextStyle appTextStyle ({
  Color color = greyDark,
  double fontSize = 14.0,
  String fontFamily = 'M_Plus_Rounded_1c',
  FontWeight fontWeight = FontWeight.w700,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight
  );
}

TextStyle appTextStyleEn ({
  Color color = greyDark,
  double fontSize = 14.0,
  String fontFamily = 'Quicksand',
  FontWeight fontWeight = FontWeight.w700,
}) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight
  );
}