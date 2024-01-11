import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppSize {
  static final double width = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  static final double height = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
}

class ContanierSize {
  static const double regular = 30.0;
}