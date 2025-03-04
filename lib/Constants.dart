import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double screenWidth = 980;
double screenHeight = 980;

bool isWeb(BuildContext context) {
  screenWidth = MediaQuery.sizeOf(context).width;
  screenHeight = MediaQuery.sizeOf(context).height;
  return kIsWeb && MediaQuery.sizeOf(context).width > 980;
}

TextStyle boldStyle = const TextStyle(
    fontSize: 94,
    fontWeight: FontWeight.bold,
    // fontStyle: FontStyle.,
    color: ColorTheme.mainTextColor,
    fontFamily: 'PlayfairDisplay');
TextStyle thickStyle = const TextStyle(
    fontSize: 74,
    fontWeight: FontWeight.bold,
    color: ColorTheme.mainSubTextColor,
    fontFamily: 'PlayfairDisplay');
TextStyle headingText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorTheme.tagTextColor,
    fontFamily: 'PlayfairDisplay');
TextStyle pageHeadingText = const TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w600,
    color: ColorTheme.mainTextColor,
    fontFamily: 'PlayfairDisplay');
TextStyle normalText = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ColorTheme.tagTextColor,
    fontFamily: 'PlayfairDisplay');
TextStyle normalText2 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorTheme.tagTextColor,
    fontFamily: 'PlayfairDisplay');
TextStyle simpleText = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorTheme.tagTextColor,
    fontFamily: 'PlayfairDisplay');

class ColorTheme {
  static const Color tagTextColor = Color.fromRGBO(43, 45, 48, 1.0);
  static const Color navBarColor = Color.fromRGBO(165, 60, 204, 1.0);
  static const Color bgColor = Color.fromRGBO(204, 228, 250, 1.0);
  static const Color mainTextColor = Color.fromRGBO(9, 3, 74, 1.0);
  static const Color mainSubTextColor = Color.fromRGBO(2, 2, 2, 1.0);
  static const Color lightGrey = Color.fromRGBO(16, 15, 15, 0.05);
  static const Color subscribeButtonColor =
      Color.fromRGBO(59, 220, 150, 0.8745098039215686);
  static const Color serviceCardColor =
      Color.fromRGBO(83, 83, 130, 0.050980392156862744);
}
