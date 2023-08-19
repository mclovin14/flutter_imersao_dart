import 'package:flutter/cupertino.dart';

class BarbershopNavGlobalKey {
  static BarbershopNavGlobalKey? _instance;
  final navKey =  GlobalKey<NavigatorState>();
  // Avoid self instance
  BarbershopNavGlobalKey._();
  static BarbershopNavGlobalKey get instance =>
      _instance ??= BarbershopNavGlobalKey._();
}
