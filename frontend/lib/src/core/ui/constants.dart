import 'package:flutter/material.dart';


sealed class FontConstants{
  static const fontFamily = 'Poppins';
}
sealed class ColorsConstants{
  static const brown =  Color(0xffB07B01);
  static const black =  Color(0xff000000);
  static const white =  Color(0xffFFFFFF);
  static const grey =  Color(0xff999999);
  static const red =  Color(0xffEB1212);
  static const ice =  Color(0xffE6E2E9);
}

sealed class ImageConstansts {
  static const String backgroundChair = 'assets/images/background_image_chair.jpg';
  static const String avatar = 'assets/images/avatar.png';
  static const String logo = 'assets/images/imgLogo.png';
}