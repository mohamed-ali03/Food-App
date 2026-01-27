import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenHight;
  static late double screenWidth;

  static late double blockHight;
  static late double blockWidth;

  void init(BuildContext context) {
    final size = MediaQuery.of(context).size;

    screenHight = size.height;
    screenWidth = size.width;

    blockHight = screenHight / 100;
    blockWidth = screenWidth / 100;
  }
}
